%% 
% Question 4 from 2021 final and Question 4 from 2021 makeup
% 
% An error code has a Hamming distance of:

ham_dist = 5 % = 2d + 1 - INPUT
%% 
% OOK modulation is used: 

modulation_factor = 1 % Orthogonal Signals - ASK, OOK
% modulation_factor = 2 % Antipodal Signals - BPSK
%% 
% _(Note that modulation_factor is not the actual name of the variable, I cannot 
% find the name, do not specify a name for it)_
% 
% with a SNR of:

SNR_dB = 3 % dB - INPUT
%% 
% What is the probability that there is an undetected error in a sequence of:

sequence_length = 6 % bits - INPUT
%% 
% Answer:

% 2d + 1 = hamming distance
d = (ham_dist - 1) / 2

% We can detect d + 1 erroneous bits 
detectable_errors = d + 1

SNR = 10^(SNR_dB / 10)
P_err = qfunc(sqrt(SNR * modulation_factor))

% We need to figure out the total probability of there being
% more errors than we can detect
prob_undetect_err = 0;
for i = (detectable_errors + 1):sequence_length
    prob_undetect_err = prob_undetect_err + ...
            nchoosek(sequence_length, i) * P_err^i * (1 - P_err)^(sequence_length - i);
end
%% 
% if sequence_legth = m and detectable errors + 1 = k
% 
% $$\textrm{Probability}\;\textrm{of}\;\textrm{undetected}\;\textrm{error}=\sum_{i=k}^{N=m} 
% C_m^i {\;\varepsilon }^i {\;\left(1-\varepsilon \right)}^{\left(m-i\right)}$$
% 
% This is kind of the opposite way of doing it. Instead of adding up the probabilities 
% from 0 to 3 and subtracting from 1, I am adding up all the probabilities of 
% 4 and higher.

prob_undetect_err % - OUTPUT ---->