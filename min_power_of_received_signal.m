%% 
% The noise temperature of a receiver is:

T_rx = 1000 % Kelvin - INPUT
%% 
% And it is attached to an antenna with a noise temperature of:

T_ant = 100 % Kelvin - INPUT
%% 
% What should be the minimum power of the signal to provide an SNR of:

SNR_dB = 10 % dB - INPUT
%% 
% Ts was supposed to be given, assume a value if it is not given and state the 
% assumed value

T_s = 0.0001 % - INPUT
%% 
% Answer:

k = 1.38e-23 % Boltzmann Constant
%% 
% $$N_o =k\;\left(T_{\textrm{RX}} +T_A \right)$$

N_o = k * (T_rx + T_ant)
%% 
% $${\textrm{SNR}}_{\textrm{dB}} =10\;\log_{10} \left({\textrm{SNR}}_{\textrm{lin}} 
% \right)$$

% Rearrange for SNR_lin
SNR_lin = 10^(SNR_dB / 10)
%% 
% $$\textrm{SNR}=\frac{E_o }{N_o }=\frac{P_S T_S }{N_o }$$
% 
% $$P_S =\frac{\textrm{SNR}\;N_o }{T_S }$$

P_signal = SNR_lin * N_o / T_s % - OUTPUT --------------------->