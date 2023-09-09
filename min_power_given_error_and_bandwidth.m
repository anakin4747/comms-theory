%% 
% What should the minimum power level of the received signal (in dBm) in a receiver 
% using equal power signals shown in Fig 1. to provide probability of error no 
% higher than:

P_err = 0.15 % - INPUT
%% 
% if the bandwidth and noise temperature are:

bandwidth_k = 20 % kHz - INPUT
T_noise = 900 + 25*6 % Kelvin - INPUT
%% 
% _Look at the figure provided and determine whether it is antipodal or orthogonal._
% 
% _If one signal is just a negative image of the other than they are considered 
% *antipodal signals.* If one signal has the same absolute area as the other than 
% they are *orthogonal signals* (in other words they have equal power but look 
% different)._
% 
% _*Antipodal signals have twice the signal energy than that of orthogonal signals 
% so set the below value to 2 if it is antipodal or 1 if it is orthogonal*_

energy_factor = 2 % - INPUT
%% 
% Note that energy_factor is not a actual term so while writing this down leave 
% it as an unnamed integer.
% 
% Answer:

% P_err = Q(sqrt(SNR*energy_factor))
SNR = qfuncinv(P_err)^2 / energy_factor

% Boltzmann constant
k = 1.38e-23; 

% Convert from kHz to Hz
bandwidth = bandwidth_k * 1e3;

% P_noise = kTB
P_noise = k * T_noise * bandwidth

% Calculate linear signal power from SNR = Ps / Pn
P_signal = SNR * P_noise

% Convert to dBm Ps_dBm = 10log10(Ps/1mW)
P_signal_dBm = 10 * log10(P_signal / 1e-3) % - OUTPUT ----->