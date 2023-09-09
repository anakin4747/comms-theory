%% 
% Calculate the level of a signal received in an antenna with an impedance of:

impedance = 24 % Ohms - INPUT
%% 
% to provide a SNR of:

SNR_dB = 10 % dB - INPUT
%% 
% if the receiver temperature is:

T_rx = 1200 % (Tsys + Ta) Kelvin - INPUT
%% 
% and a bandwidth of:

bandwidth = 10 % MHz - INPUT
%% 
% Answer:

% Boltzmann constant
k = 1.38e-23 

% Convert MHz to Hz
bandwidth = bandwidth * 1e6
%% 
% $$P_{\textrm{noise}} =k\;\left(T_{\textrm{sys}} +T_a \right)\;\textrm{BW}$$

P_noise = k * T_rx * bandwidth

% Convert SNR to linear scale
SNR_lin = 10^(SNR_dB / 10)

% Rearrange SNR = P_signal / P_noise
P_signal = SNR_lin * P_noise
%% 
% $$P_{\textrm{signal}} =\frac{V_{\textrm{in}}^2 }{R_{\textrm{in}} }$$
% 
% $$V_{\textrm{in}} =\sqrt{P_{\textrm{signal}} \;R_{\textrm{in}} }$$

V_in = sqrt(P_signal * impedance) % - OUTPUT ----------------->