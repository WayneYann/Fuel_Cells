%Wang Journal of The Electrochemical Society, 153 (9) A1732-A1740 (2006)
N = 400; %max overpotential

%Tafel eta = a + b*log(i)
%Butler-Volmer j = jo(e^(-alph*n*f*eta)-e^((1-alpha)*n*f*eta)
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
ylim([0 1200])


