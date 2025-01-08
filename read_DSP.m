% this code demonstrate method a general use of DSP-CEST quantification
clear;
% set the low and high power
w1_matrix=[0.5, 1];

% load demonstration data
load('simulated_Zspectra');

% set parameters
B0_field=200; % Hz for 1ppm at 4.7T
k=[-10,-8.75,-7.5,-6.25,-5:0.125:5,6.25,7.5,8.75,10]'*B0_field; % frequency offet
cos2_theta_H=k.^2./((w1_matrix(2).*42.6).^2+k.^2); % cos2 for high power
cos2_theta_L=k.^2./((w1_matrix(1).*42.6).^2+k.^2); % cos2 for low power
sin2_theta_H=(w1_matrix(2).*42.6).^2./((w1_matrix(2).*42.6).^2+k.^2); % sin2 for high power
sin2_theta_L=(w1_matrix(1).*42.6).^2./((w1_matrix(1).*42.6).^2+k.^2); % sin2 for low power
beta_Aux=(w1_matrix(1)/w1_matrix(2))^2; % set auxilary parameter.

% set ref and label signal
Slab_spectra=Z_spectra_0p5uT;
Sref_spectra=1./(1+(1./Z_spectra_1p0uT-1).*beta_Aux);

% caluse MTR and AREX quantified DSP spectra
MTR_DSP_spectra=Sref_spectra-Slab_spectra;
AREX_DSP_spectra=(1./Slab_spectra-1./Sref_spectra).*R1W.*cos2_theta_L;
 
% plot MTR and AREX quantified DSP spectra
figure (1)
plot(MTR_DSP_spectra)
figure (2)
plot(AREX_DSP_spectra)
