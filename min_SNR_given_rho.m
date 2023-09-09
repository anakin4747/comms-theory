%% 
% What should the minimum SNR (in dB) be in a receiver using equal power signals 
% with correlation factor:

rho = 0.4 % - INPUT
%% 
% to provide a probability of error no higher than:

P_err = 0.15 % - INPUT
%% 
% Answer:
% 
% $$P_{\textrm{err}} =Q\left(\sqrt{\textrm{SNR}\left(1-\rho \right)}\right)$$
% 
% $$\textrm{SNR}=\frac{{\left(Q\right.}^{-1} {\left.\left(P_{\textrm{err}} \right)\right)}^2 
% }{\left(1-\rho \right)}$$

SNR_lin = qfuncinv(P_err)^2 / (1 - rho)

% Convert to dB
SNR_dB = 10 * log10(SNR_lin) % - OUTPUT ------>