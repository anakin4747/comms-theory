%% 
% Question 4 from practice exam
% 
% An error code has a Hamming distance of:

ham_dist = 5 % = 2d + 1 - INPUT
%% 
% Probability of error in a single bit is

P_err = 0.1 % - INPUT
%% 
% What is the probability that there is an undetected error in a sequence of:

sequence_length = 8 % bits - INPUT
%% 
% Answer:

% 2d + 1 = hamming distance
d = (ham_dist - 1) / 2

% We can detect d + 1 erroneous bits 
detectable_errors = d + 1

% We need to figure out the total probability of there being
% more errors than we can detect
prob_undetect_err = 0;
for i = (detectable_errors + 1):sequence_length
    nchoosek(sequence_length, i) * P_err^i * (1 - P_err)^(sequence_length - i)
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