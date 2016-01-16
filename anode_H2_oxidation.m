N = 1; %max overpotential
kB = 8.61733*10^-5; %ev/K
e = 1.60218 *10^-19; % Coloumbs
T = 298; %K
n = 2;
R = 8.314; %J/molK
F = 96485; %A*s/mol
eta = 0:0.001:N; %V overpotential
%Butler-Volmer with alpha = 0.48
%{
%Norskov 2005
delGh = @(delEh) delEh + 0.24; %Delta G of H adsoprtion
theta = @(K) K/(1+K); %Fractional coverage of Metal
K = @(delGh,T) -delGh/(kB*T);
k0 = 200; % 1/(s*sites)
%}

%Skulason_2007
SA = 6.64*10^-16; %cm^2/atom
v = 10^13; %1/(s*sites); prefactor
EaT = 0.8; %Tafel Reaction eV
koT = v*exp(-EaT/(kB*T));
joT = koT*e/SA;
alphaT = .35; %anodic transfer coefficient

EaH = 0.6; %Heyrovsky Reaction eV
koH = v*exp(-EaH/(kB*T));
joH = koH*e/SA;
alphaH = .52; %anodic transfer coefficient


jL = 100; %A/cm^2 mass transport limiting current
jKT = jo*(exp(2*alphaT*F/(R*T)*eta)-exp(-2*(1-alphaT)*F/(R*T)*eta)); %kinetic current density
jfT = jo*(exp(2*alphaT*F/(R*T)*eta)); %kinetic current of forward reaction
jVBT = jKT./(1+jfT/jL);

jKH = jo*(exp(2*alphaH*F/(R*T)*eta)-exp(-2*(1-alphaH)*F/(R*T)*eta)); %kinetic current density
jfH = jo*(exp(2*alphaH*F/(R*T)*eta)); %kinetic current of forward reaction
jVBH = jKH./(1+jfH/jL);

%combined Heyrovsky and Volmer
jK = jKT+jKH;
jf = jfT+jfH;

jVB = jK./(1+jf/jL);

%Rheinlander 2014 (Experimental)
alphaE = 0.48;
joE = 0.55*10^-3;
jKE = jo*(exp(2*alphaE*F/(R*T)*eta)-exp(-2*(1-alphaE)*F/(R*T)*eta)); %kinetic current density
jfE = jo*(exp(2*alphaE*F/(R*T)*eta)); %kinetic current of forward reaction
jVBE = jKE./(1+jfE/jL);


figure(3)
plot(eta,jVB,eta,jVBE,eta,jVBT,eta,jVBH);
xlabel('Overpotential (V)');
ylabel('Current density (A/cm^2)');
legend('DFT-current','Experimental-current','DFT-Tafel','DFT-Heyrovsky')
title('Current Density with limiting current of 100 A')
ylim([0 125])
xlim([0 0.7])
