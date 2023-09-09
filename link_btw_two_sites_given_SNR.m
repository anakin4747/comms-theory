clear
%% 
% A link between two sites is organized as a two-hop relay system. The first 
% hop has a SNR of:

SNR1_dB = 4 % dB - INPUT
%% 
% The second hop has a SNR of:

SNR2_dB = 5 % dB - INPUT
%% 
% The data rate used is:

link_data_rate = 12 % kbps - INPUT
%% 
% The source of information produces:

source_data_rate = 10000 % bigits/second - INPUT
%% 
% The source consists of 5 (or 6) different symbols with probabilities:

s1 = 0.1 % - INPUT
s2 = 0.05 % - INPUT
s3 = 0.1 % - INPUT
s4 = 0.2 % - INPUT
s5 = 0.05 % - INPUT if 6 symbols
s6 = 1 - s1 - s2 - s3 - s4 - s5 % For 6 symbols
% prob = [s1 s2 s3 s4 s5]; % Comment out if 6 symbols
prob = [s1 s2 s3 s4 s5 s6]; % For 6 symbols
%% 
% The sensor first records: 

recording_time = 10 % seconds - INPUT
%% 
% of data onto a hard drive using:

bigits_per_sym = 3 % bigits/symbol - INPUT
%% 
% Data is then compressed with Huffman code based on grouping of two symbols
% 
% a) How much data will be stored on the hard drive in the raw form?

% Calculate size of data in bigits
stored_data_bits = source_data_rate * recording_time % - OUTPUT ------->

% Calculate size of data in symbols
stored_data_symbols = stored_data_bits / bigits_per_sym % - OUTPUT ---->
%% 
% b) Calculate the amount of data after compression and the efficiency of the 
% code

% Allocate super symbols symbols and their prob 
super_symbols = strings(length(prob)^2, 1);
super_sym_prob = zeros(length(prob)^2, 1);
i = 1; % Index for super_symbols

% Generate Super Symbols and their probability
for sym_index_1 = 1:length(prob)
    for sym_index_2 = 1:length(prob)
        super_symbols(i) = sprintf("s%d s%d", ...
                                sym_index_1 - 1, sym_index_2 - 1);
        super_sym_prob(i) = prob(sym_index_1) * prob(sym_index_2);
        i = i + 1;
    end
end; clear i sym_index_1 sym_index_2

% Generate dictionary for Huffman code
dict = huffmandict(1:length(prob), prob);
% Grab codes from dictionary
codes = dict(:, 2);

% Allocate space for Table
super(1:length(super_symbols)) = struct('Symbols', strings(1), ...
    'Prob', zeros(1), 'Code', zeros(1));

% Construct a struct for table information
% for strct = 1:length(super_symbols)
%     super(strct) = struct('Symbols', super_symbols(strct), ...
%         'Prob', super_sym_prob(strct), 'Code', codes(strct));
% end; clear strct
% open('super') 

% bigits per sup_sym
L = 0;
% Entropy
H = 0;
% Calculates Entropy and Bar L using equations below
for cell = 1:length(prob)
    L = L + length(cell2mat(codes(cell))) * prob(cell);
    H = H - prob(cell) * log2(prob(cell));
end; clear cell
%% 
% $$H\left(x\right)=-\sum_{i\;=\;0}^{N-1} p_i {\;\log }_2 \left(p_i \right)$$        
% $$\bar{L} =\sum_{i\;=\;0}^{N-1} L_i {\;p}_i$$

H % Entropy (in bits/sym) - OUTPUT ------------------------>
L % bar L (in bigits/sup_sym) - OUTPUT ------------------------>
%% 
% $$\eta =\frac{H\left(x\right)}{\bar{L} }$$

% Efficiency (unitless)
efficiency = H / L * 100 % - OUTPUT ----------------------->

% Rs = (bigits/s) / (bigits/sym) = (sym/s)
symbol_rate = source_data_rate / bigits_per_sym;

% Number of symbols per super symbol
sym_per_sup_sym = 2;
% Rss = (sym/s) / (sym/sup_sym) = (sup_sym/s)
sup_sym_rate = symbol_rate / sym_per_sup_sym

% Total number of super symbols = (sup_sym/s) * s = sup_sym
num_of_sup_sym = sup_sym_rate * recording_time

% Total number of bigits = sup_sym * (bigits/sup_sym) = bigits
compressed_data_size = ceil(num_of_sup_sym * L) % - OUTPUT --------->
% Round up since you cant have a fraction of a bit
%% 
% c) What is the capacity per channel use of the channel?

% Convert to linear by rearranging SNR_dB = 10log10(SNR_lin)
SNR1_lin = 10^(SNR1_dB / 10)
SNR2_lin = 10^(SNR2_dB / 10)

% OOK - Orthogonal Signals
P_err1 = qfunc(sqrt(SNR1_lin))

% BPSK - Antipodal Signals
P_err2 = qfunc(sqrt(2*SNR2_lin))

% Probability it errors in the first channel and 
% stays wrong through the second channel
P_err_first = P_err1 * (1 - P_err2);

% Probability it is correct in the first channel but
% errors in the second
P_err_second = (1 - P_err1) * P_err2;

% The probability of either event occuring
P_err = P_err_first + P_err_second

% Confusion H(e) = -elog2(e) - (1-e)log2(1-e)
H_e = - P_err*log2(P_err) - (1 - P_err)*log2(1 - P_err)

% Capacity per use (in bits/use) C' = 1 - H(e)
C = 1 - H_e % - OUTPUT ------------------------------->
%% 
% d) How long does it take to transmit the data?

comp_data_at_capacity = compressed_data_size / C

% Transmission time at capacity (link rate converted from kbps to bps)
trans_time = comp_data_at_capacity / (link_data_rate * 1e3) % - OUTPUT ->
%% 
% e) How many bits will be in error?

erroneous_bit_count = ceil(compressed_data_size * P_err) % - OUTPUT ----->