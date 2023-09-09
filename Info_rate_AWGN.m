%% 
% What is the maximum information rate in a AWGN channel with bandwidth and 
% SNR of:

bandwidth_MHz = 10 % MHz - INPUT
SNR_dB = 7 % dB - INPUT
%% 
% Answer:
% 
% $$R_I \le C=W\log_2 \left(1+{\textrm{SNR}}_{\textrm{lin}} \right)$$

% Convert SNR to linear
SNR_lin = 10^(SNR_dB / 10)

% Convert bandwidth from MHz to Hz
bandwidth = bandwidth_MHz * 1e6

% Calculate Shannon Capacity
capacity = bandwidth * log2(1 + SNR_lin)

% Max Info rate = capacity (in bits/second)
info_rate = capacity % - OUTPUT ------------------------>