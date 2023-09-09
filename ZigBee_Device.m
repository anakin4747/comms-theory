%% 
% A ZigBee device operates at a frequency and rate of:

f_o = 2400 % MHz - INPUT
data_rate = 40 % Kbps - INPUT
%% 
% BPSK modulation is used. The output power of the transmitter is in the range 
% of 0 to 20dBm. The gain of the receiver and transmitter antennas are:

G_dBi = 2 % dBi - INPUT
%% 
% At a distance of:

distance = 10 % m - INPUT
%% 
% from the receiver, the probability of error is:

P_err = 0.1 % - INPUT
%% 
% if the power level is:

P_tr_dBm = 10 % dBm - INPUT
%% 
% a) Calculate noise power in the receiver

% Convert Power from dBm to Watts
P_tr_lin = 10^(P_tr_dBm / 10) * 1e-3 % Watts

% Convert Antenna Gain from dBi to linear gain
G_tr = 10^(G_dBi / 10)
G_rx = G_tr

% Calculate wavelength of antenna
wavelength = 3e8 / (f_o * 1e6)

% Calculate Power of receiver
P_rx_lin = P_tr_lin * G_rx * G_tr * (wavelength / (4*pi*distance))^2

% Calculate SNR from P_err = Q(sqrt(2*SNR))
SNR_lin = (qfuncinv(P_err))^2 / 2

% Calculate noise power SNR_lin = P_rx_lin / P_noise
P_noise = P_rx_lin / SNR_lin % - OUTPUT ----------------------------->
%% 
% b) What is the maximum distance of operation if the probability of error is 
% no more than:

P_err_max = 0.15 % - INPUT
%% 
% Answer:

% Calculate SNR from P_err_max = Q(sqrt(2*SNR))
SNR_lin = qfuncinv(P_err_max)^2 / 2

% Calculate receiver power from noise power and SNR
P_rx = SNR_lin * P_noise

% At mininmum transmitter power (0 dBm)
P_tr_min = 10^(0/10) * 1e-3

% Rearrange P_rx = P_tr*G*G*(wave/4pi*distance)^2
max_distance = wavelength / ...
    (4 * pi * sqrt(P_rx / (P_tr_min * G_rx * G_tr))) % - OUTPUT ---------->
%% 
% c) What is the probability of error at the following distance and power level:

distance = 15 % m - INPUT
P_tr_dBm = 15 % dBm - INPUT
%% 
% Answer:

% Convert Power from dBm to Watts
P_tr_lin = 10^(P_tr_dBm / 10) * 1e-3

% Calculate Power of receiver
P_rx_lin = P_tr_lin * G_rx * G_tr * (wavelength / (4*pi*distance))^2

% Calculate linear SNR
SNR_lin = P_rx_lin / P_noise

% Calculate error probability
P_err = qfunc(sqrt(2 * SNR_lin)) % - OUTPUT ------------->
%% 
%