%% 
% A satelite based system has a transmitter (Ground Station) with gain:

G_tr_dBm = 70 % dBm - INPUT
%% 
% The satelite (receiver) is separated by a distance of:

distance_km = 386000 % km - INPUT
%% 
% The operating frequency is:

f_o_GHz = 3 % GHz - INPUT
%% 
% Modulation format is BPSK. The system provides a data rate of:

data_rate = 100 % bigits/second - INPUT
%% 
% and a probability of error of:

P_err = 0.01 % - INPUT
%% 
% There is a power loss of:

P_loss_dB = 3 % dB - INPUT 
%% 
% a) Calculate the minimum SNR required for such a system and what is the maximum 
% noise power density and noise temperature of the receiver
% 
% $$\textrm{SNR}=\frac{1}{2}{\left\lbrack Q^{-1} \left(P_{\textrm{err}} \right)\right\rbrack 
% }^2$$

% Rearrange P_err = Q(sqrt(2*SNR_lin)) 
SNR_lin = qfuncinv(P_err)^2 / 2 % - OUTPUT ------------>
SNR_dB = 10 * log10(SNR_lin) % - OUTPUT --------------->

% Convert km to m
distance_m = distance_km * 1e3;

% Convert GHz to Hz
f_o = f_o_GHz * 1e9;
%% 
% $$P_{\textrm{TR}} ={10}^{\left(\frac{P_{\textrm{dBm}} }{10}\right)} 1\textrm{mW}$$

% Convert from dBm to linear
P_tr = 10^(G_tr_dBm / 10) * 1e-3
%% 
% $$P_{\textrm{loss},\textrm{dB}} =-10\;\log_{10} \left(\frac{P_{\textrm{loss}} 
% }{P_{\textrm{TR}} }\right)$$             $$P_{\textrm{loss},\textrm{dB}} =10\;\log_{10} 
% \left(\frac{P_{\textrm{TR}} }{P_{\textrm{RX}} }\right)$$
% 
% $$P_{\textrm{loss}} =\frac{P_{\textrm{TR}} }{{10}^{\left(\frac{P_{\textrm{loss},\textrm{dB}} 
% }{10}\right)} }$$

% Convert from dB to linear
P_loss_lin = P_tr / 10^(P_loss_dB / 10)

% Received power
P_rx = P_tr - P_loss_lin
%% 
% $$\textrm{SNR}=\frac{P_{\textrm{RX}} }{N_o W}=\frac{P_{\textrm{RX}} }{k\;TR_S 
% }$$
% 
% $$T=\frac{P_{\textrm{RX}} }{k\;R_S \;\textrm{SNR}}$$

% Boltzmann Constant
k = 1.38e-23
T_noise = P_rx / (k * data_rate * SNR_lin) % - OUTPUT -------->

% Power Spectral Density = k * T_noise (in joules)
N_o = k * T_noise % - OUTPUT -------------------------->
%% 
% b) Calculate bandwidth needed for such a channel and its Shannon capacity

bandwidth = data_rate

% Capacity = BW * log2(1 + SNR) (in bits/second)
capacity = bandwidth * log2(1 + SNR_lin) % - OUTPUT ---->
%% 
% c) What is the capacity of this system per use of such system

% Confusion H(e) = elog2(e) + (1 - e)log2(1 - e) 
confusion = -P_err * log2(P_err) - (1 - P_err) * log2(1 - P_err);
% C' = 1 - H(e) (in bits/use)
cap_per_use = 1 - confusion % - OUTPUT ----->
%% 
% d) How long will it take to transmit a single black and white image without 
% compression with dimensons:

dimension = 256 % - INPUT - Likely won't change
%% 
% and each pixel is represented by 

bits_per_pixel = 8 % - INPUT - Likely won't change
%% 
% Answer:

% number of bits in an image = number of pixels * bits/pixel
bit_count = dimension^2 * bits_per_pixel

% Time it takes to send those bits (in seconds)
transmission_time = bit_count / data_rate % - OUTPUT --------------------->
%% 
% e) How many errors will happen during this transmission?

% Number of errors = number of bits * probability of error
number_of_errors = ceil(bit_count * P_err) % - OUTPUT -------------------->
%% 
% f) How long does it take for a signal to propagate from the transmitter to 
% the receiver?

% Radiowaves travel at near the speed of light
c = 3e8;

% Time (in seconds) = distance (in m) / speed (in m/s)
propagation_time = distance_m / c % - OUTPUT ----------------------------->