%% 
% From Question 9 of the sample Exam
% 
% A system operates at a frequency of:

f_o_MHz = 450 % MHz - INPUT 
%% 
% The radiated power and antenna gains are:

P_tr_dBm = 4 % dBm - INPUT
G_tr_dBi = 4 % dBi - INPUT
G_rx_dBi = 5 % dBi - INPUT
%% 
% The system is operating with a bandwidth of:

bandwidth_MHz = 5 % MHz - INPUT
%% 
% at standard temperature. How long will it take to transmit:

data_size_Mbits = 100 % Mbits - INPUT
%% 
% of information, assuming that the link is used at:

percent_capacity = 90 % - INPUT
%% 
% Distance wasnt given but is needed to solve this question, I assume a distance 
% of:

distance = 10 % m - INPUT
%% 
% Answer:
% 
% $$\lambda =\frac{c}{f_o }$$        $$c=3{\textrm{x10}}^8$$

% Convert MHz to Hz
f_o = f_o_MHz * 1e6
% Wavelength = speed of light / operating frequency
wavelength = 3e8 / f_o
%% 
% $$G_{\textrm{dBi}} =10\;\log_{10} \;\left(G\right)$$

% Convert from dBi to linear
G_tr = 10^(G_tr_dBi / 10)
G_rx = 10^(G_rx_dBi / 10)
%% 
% $$P_{\textrm{dBm}} =10\;\log_{10} \;\left(\frac{P}{1\textrm{mW}}\right)$$

% Convert from dBm to linear
P_tr = 10^(P_tr_dBm / 10) * 1e-3
%% 
% $$P_{\textrm{RX}} =P_{\textrm{TR}} \;G_{\textrm{TR}} \;G_{\textrm{RX}} \;{\left(\frac{\lambda 
% }{4\;\pi \;d}\right)}^2$$

% Calculate received linear power (in Watts)
P_rx = P_tr * G_tr * G_rx * (wavelength / (4*pi*distance))^2
%% 
% $$\textrm{SNR}=\frac{P_{\textrm{RX}} \;}{N_o W}=\frac{P_{\textrm{RX}} }{k\;T_o 
% W}$$     $$\textrm{Assume}\;\;T_o =290\;\textrm{Kelvin}$$

% Boltzmann Constant
k = 1.38e-23
% Standard Temperature
T_o = 290 % Kelvin
% Convert from MHz to Hz
bandwidth = bandwidth_MHz * 1e6

SNR = P_rx / (k * T_o * bandwidth)
%% 
% $$C=W\;\log_2 \left(1+\textrm{SNR}\right)$$

% Capacity
C = bandwidth * log2(1 + SNR)
%% 
% $$\textrm{Transmit}\;\textrm{Time}=\frac{\textrm{Data}}{\left(\textrm{percent}\;\textrm{Capacity}\right)\;C}$$

% Convert Mbits to bits
data_size = data_size_Mbits * 1e6
percent_capacity = percent_capacity / 100

% Transmission time in seconds
trans_time = data_size / (percent_capacity * C) % - OUTPUT -------->
%% 
%