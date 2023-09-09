%% 
% The noise temperature of a receiver is:

T_rx = 1000 % Kelvin - INPUT
%% 
% And it is attached to an antenna with a noise temperature of:

T_ant = 100 % Kelvin - INPUT
%% 
% and an impedance of:

antenna_impedance = 8 % Ohms - INPUT
%% 
% What should be the minimum voltage (in dBmV) of the signal to provide an SNR 
% of:

SNR_dB = 5 % dB - INPUT
%% 
% for a transmission with:

trans_rate = 25 % kbits/sec - INPUT
%% 
% The transmission rate is the bandwidth 

bandwidth = trans_rate * 1000; 
% trans_rate * 1k since input is in kHz

k = 1.38e-23 % Boltzmann Constant
% P_n = kTB
noise_power = k * (T_rx + T_ant) * bandwidth

% Rearrange SNR_dB = 10log10(SNR_lin) for SNR_lin
SNR_lin = 10^(SNR_dB / 10)

% Find signal power 
signal_power = noise_power * SNR_lin

% Rearrange P = V^2/R for voltage
voltage = sqrt(signal_power * antenna_impedance)

% Convert to dBmV = 20log10(V / 1mV)
volt_dBmV = 20 * log10(voltage / 1e-3) % - OUTPUT