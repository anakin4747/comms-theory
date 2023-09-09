%% 
% Question 1 from practice exam
% 
% Calculate the entropy of a source which produces symbols with probabilities:

s1 = 0.1   % - INPUT
s2 = 0.3   % - INPUT
s3 = 0.05  % - INPUT
s4 = 1 - s1 - s2 - s3
prob = [s1, s2, s3, s4];
%% 
% If the sampling rate is:

symbol_rate_ksym = 10 % ksymbols/second - INPUT
%% 
% What is the information rate?
% 
% Answer:

H = 0; % Entropy
for i = 1:length(prob)
    H = H - prob(i)*log2(prob(i));
end
%% 
% $$H\left(x\right)=-\sum_{i=0}^{N-1} p_i \log_2 p_i$$

% Entropy (in bits/symbol)
H % - OUTPUT -------------------------------------------->

% Convert ksymbols/second to symbols/second
symbol_rate = symbol_rate_ksym * 1e3
%% 
% $$R_I =H\left(x\right){\;R}_S$$

% Information rate (in bits/second)
information_rate = H * symbol_rate % - OUTPUT ----------->