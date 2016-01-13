
N = 400; %max overpotential

%Wang Journal of The Electrochemical Society, 153 (9) A1732-A1740 (2006)
jo = 2; %mA/cm^2 exchange flux at equilibrium
b = 30; %mV/decade parameter from rotating disk electrode (T?, alpha?)
eta = 0:N; %mV overpotential
jL = 1000; %mV/cm^2 mass transport limiting current
jK = jo*(exp(2.3*eta/b)-exp(-2.3*eta/b)); %kinetic current density
jf = jo*(exp(2.3*eta/b)); %kinetic current of forward reaction
jVB = jK./(1+jf/jL);


figure(1)
plot(eta,jK,eta,jVB);
xlabel('overpotential (mV)');
ylabel('current density (mA/cm^2)');
legend('VB-kinetic current','VB-current')
title('Reproducing Results from Wang')
ylim([0 1200])

%Butler-Volmer with alpha = 0.48
T = 274; %K
jo = 2; %mA/cm^2 exchange flux at equilibrium
n = 2;
alpha = .48; %anodic transfer coefficient
R = 8.314; %J/molK
F = 96485; %A*s/mol
eta2 = 0:0.001:(N/1000); %mV overpotential
jL = 1000; %mA/cm^2 mass transport limiting current
jK = jo*(exp(2*alpha*F/(R*T)*eta2)-exp(-2*alpha*F/(R*T)*eta2)); %kinetic current density
jf = jo*(exp(2*alpha*F/(R*T)*eta2)); %kinetic current of forward reaction
jVB = jK./(1+jf/jL);

figure(2)
plot(eta2,jK,eta2,jVB);
xlabel('overpotential (V)');
ylabel('current density (mA/cm^2)');
legend('VB-kinetic current','VB-current')
title('Data from Gasteiger')
ylim([0 1200])

%does not follow alpha = 2.3*RT/(b*F)

