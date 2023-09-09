%% 
% The transmitting power of a WiFi router is:

P_tr = 10 % mW - INPUT
%% 
% at a frequency:

f_o_G = 5.2 % GHz - INPUT
%% 
% What is the received power at the distance of:

distance = 30 % m - INPUT
%% 
% from the router if both antennas have a gain of:

G_ant_dBi = 2.5 % dBi - INPUT
%% 
% Answer:

% Convert from mW to W
P_tr = P_tr * 1e-3

% Convert gain to linear
G_tr = 10^(2 / 10)
G_rx = 10^(3 / 10)

% Convert from GHz to Hz
f_o = f_o_G * 1e9
%% 
% $$\lambda =\frac{c}{f_o }$$        $$c=3{\textrm{x10}}^8$$

wavelength = 3e8 / f_o
%% 
% $$P_{\textrm{RX}} =P_{\textrm{TR}} \;G_{\textrm{TR}} \;G_{\textrm{RX}} \;{\left(\frac{\lambda 
% }{4\;\pi \;d}\right)}^2$$

% Calculate received linear power (in Watts)
P_rx = P_tr * G_tr * G_rx * ...
    (wavelength / (4*pi*distance))^2 % - OUTPUT -------->
%% 
% $$P_{\textrm{dBm}} =10\;\log_{10} \;\left(\frac{P}{1\textrm{mW}}\right)$$

% Convert to dBm Ps_dBm = 10log10(Ps/1mW) (in dBm)
P_rx_dBm = 10 * log10(P_rx / 1e-3) % - OUTPUT -------->
%% 
%