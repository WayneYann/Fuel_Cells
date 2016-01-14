N = 400; %max overpotential
kB = 8.61733*10^-5; %ev/K
e = 1.60218 *10^-19; % Coloumbs
T = 274; %K
n = 2;
R = 8.314; %J/molK
F = 96485; %A*s/mol
eta = 0:0.001:(N/1000); %V overpotential
%Butler-Volmer with alpha = 0.48
%{
%Norskov 2005
delGh = @(delEh) delEh + 0.24; %Delta G of H adsoprtion
theta = @(K) K/(1+K); %Fractional coverage of Metal
K = @(delGh,T) -delGh/(kB*T);
k0 = 200; % 1/(s*sites)
%}

%Skulason_2007
v = 10^13; %1/(s*sites); prefactor
Ea = 0.55; %Tafel Reaction eV
ko = v*exp(-Ea/(kB*T));
SA = 6.64*10^-16; %cm^2/atom
jo = ko*e/SA;

alpha = .65; %anodic transfer coefficient

%Wang_2006
jL = 1000; %mA/cm^2 mass transport limiting current
jK = jo*(exp(2*alpha*F/(R*T)*eta)-exp(-2*alpha*F/(R*T)*eta)); %kinetic current density
jf = jo*(exp(2*alpha*F/(R*T)*eta)); %kinetic current of forward reaction
jVB = jK./(1+jf/jL);

figure(3)
plot(eta,jK,eta,jVB);
xlabel('overpotential (V)');
ylabel('current density (mA/cm^2)');
legend('VB-kinetic current','VB-current')
title('Data from Gasteiger')
ylim([0 1200])


