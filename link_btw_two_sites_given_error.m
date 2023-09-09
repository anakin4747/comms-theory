%% 
% A link between two sites is organized as a two-hop relay system. The first 
% hop has a probability of error of:

P_err1 = 0.1 % - INPUT
%% 
% The second hop has a probability of error of:

P_err2 = 0.2 % - INPUT
%% 
% The data rate used is:

link_data_rate = 10 % kbps - INPUT
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

bigits_per_sym = 1 % bigits/symbol - INPUT
%% 
% Data is then compressed with Huffman code with:

efficiency = 95 % - INPUT
%% 
% and transmitted through the link at:

percent_capacity = 90 % - INPUT
%% 
% a) How much data will be stored on the hard drive in the raw form?
% 
% $$\textrm{Info}=R_b \;T$$

% Calculate size of data in bigits
stored_data_bits = source_data_rate * recording_time % - OUTPUT ------->
%% 
% b) Calculate the amount of data after compression and the efficiency of the 
% code

% Calculate H(x)
%% 
% $$H\left(x\right)=-\sum_{i=0}^{N-1} p_i \log_2 p_i$$

H = 0;
for sym = 1:length(prob)
    H = H - prob(sym)*log2(prob(sym));
end; clear sym
H
%% 
% $$R_S =\frac{R_b }{\textrm{bigits}/\textrm{symbol}}$$

% Rs = (bigits/s) / (bigits/sym) = (sym/s)
symbol_rate = source_data_rate / bigits_per_sym

% Convert efficiency to a fraction
efficiency = efficiency / 100
%% 
% $$\textrm{Data}=\frac{H\left(x\right)\;R_S \;T}{\eta }$$

compressed_data_size = ceil(H * symbol_rate * recording_time / efficiency) % - OUTPUT --------->
% Round up since you can't have a fraction of a bit
%% 
% c) What is the capacity per channel use of the channel?
% 
% $$\varepsilon =P_{\textrm{err}} =\varepsilon_1 \;\left(1-\varepsilon_2 \right)+\left(1-\varepsilon_1 
% \right){\;\varepsilon }_2$$

% Probability it errors in the first channel and 
% stays wrong through the second channel
P_err_first = P_err1 * (1 - P_err2);

% Probability it is correct in the first channel but
% errors in the second
P_err_second = (1 - P_err1) * P_err2;

% The probability of either event occuring
P_err = P_err_first + P_err_second
%% 
% $$H\left(\varepsilon \right)=-\varepsilon \;\log_2 \left(\varepsilon \right)-\left(1-\varepsilon 
% \right){\;\log }_2 \left(1-\varepsilon \right)$$

% Confusion
H_e = - P_err*log2(P_err) - (1 - P_err)*log2(1 - P_err)
%% 
% $$C^{\prime } =1-H\left(\varepsilon \right)$$

% Capacity per use (in bits/use)
C = 1 - H_e % - OUTPUT ------------------------------->
%% 
% d) How long does it take to transmit the data?
% 
% $$\textrm{Number}\;\textrm{of}\;\textrm{bigits}=\frac{\textrm{Data}}{\left(\textrm{percent}\;\textrm{capacity}\right)\;C^{\prime 
% } }$$

% Convert to fraction
percent_capacity = percent_capacity / 100

num_bits_to_trans = ceil(compressed_data_size / (percent_capacity * C))
% Round up since you can't have a fraction of a bit
%% 
% $$\textrm{Time}\;\textrm{to}\;\textrm{Transmit}=\frac{\textrm{Number}\;\textrm{of}\;\textrm{bigits}}{\textrm{link}\;\textrm{data}\;\textrm{rate}}$$

% Time (in seconds)
trans_time = num_bits_to_trans / link_data_rate % - OUTPUT --------->