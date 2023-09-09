%% 
% Question 1 from 2021 final and Question 3 from 2021 makeup
% 
% Calculate the entropy of a source which produces symbols with probabilities:

s1 = 0.4   % - INPUT
s2 = 0.2   % - INPUT
s3 = 0.05  % - INPUT
s4 = 1 - s1 - s2 - s3
prob = [s1, s2, s3, s4];
%% 
% If the bandwidth is:

BW_lim = 20; % kHz - INPUT
%% 
% Sampled at:

percent = 120 % of the Nyquist rate - INPUT
%% 
% What is the information rate?

H = 0; % Entropy
for i = 1:length(prob)
    H = H - prob(i)*log2(prob(i));
end
%% 
% $$H\left(x\right)=-\sum_{i=0}^{N-1} p_i \log_2 p_i$$

% Entropy (in bits/symbol)
H % - OUTPUT --------------------------->

BW = 2 * BW_lim * 1e3; % Bandwidth
sampling_ratio = percent / 100;
symbol_rate = sampling_ratio * BW
%% 
% $$R_I =H\left(x\right)R_S$$

information_rate = H * symbol_rate % - OUTPUT -------->