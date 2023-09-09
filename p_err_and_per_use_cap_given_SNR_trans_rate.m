%% 
% BPSK modulation is used at both links of a relay with the following respective 
% SNRs:

SNR1_dB = 5 % dB - INPUT
SNR2_dB = 7 % dB - INPUT
%% 
% What is the probability of error occuring in this relay? What is its capacity 
% per use? How many binary symbols are needed to transmit:

info_size = 0.5 % Mbits
%% 
% of information?
% 
% Answer:

% Convert SNRs to linear
SNR1_lin = 10^(SNR1_dB / 10)
SNR2_lin = 10^(SNR2_dB / 10)

% Calculate P_err for each link
P_err1 = qfunc(sqrt(2 * SNR1_lin))
P_err2 = qfunc(sqrt(2 * SNR2_lin))

% The probability of an error occuring only
% in the first link but not the second
P_err_first = (1 - P_err1) * P_err2

% The probability of an error occuring only
% in the second link but not the first
P_err_second = P_err1 * (1 - P_err2)

% Probability of either occuring
P_err = P_err_first + P_err_second % - OUTPUT ---->

% Confusion
H_e = - P_err*log2(P_err) - (1 - P_err)*log2(1 - P_err);

% Capacity per use 
C = 1 - H_e % - OUTPUT -------->

% Convert from Mbits to bits
info_size = info_size * 1e6

% Binary symbols needed (bits)
binary_symbols = info_size / C % - OUTPUT -------->
%% 
%