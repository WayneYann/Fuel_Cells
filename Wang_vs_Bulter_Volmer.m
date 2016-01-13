
N = 0.4; %max overpotential
%Butler-Volmer with alpha = 0.48
n = 2;
R = 8.314; %J/molK
F = 96485; %A*s/mol
eta2 = 0:0.001:(N/1000); %mV overpotential


T = 274; %K
P = 1.103*10^5; %Pa
HenryH2 = 0.00078;
H = 10^-7;
H2

jo = 2; %mA/cm^2 exchange flux at equilibrium
alpha = .48; %anodic transfer coefficient
jL = 1000; %mA/cm^2 mass transport limiting current

jK = jo*(exp(2*alpha*F/(R*T)*eta2)-exp(-2*alpha*F/(R*T)*eta2)); %kinetic current density
jf = jo*(exp(2*alpha*F/(R*T)*eta2)); %kinetic current of forward reaction
jVB = jK./(1+jf/jL);

figure(1)
plot(eta2,jK,eta2,jVB);
xlabel('overpotential (V)');
ylabel('current density (mA/cm^2)');
legend('VB-kinetic current','VB-current')
title('Butler-Volmer')
ylim([0 1200])

%does not follow alpha = 2.3*RT/(b*F)

