N = 1; %max overpotential
kB = 8.61733*10^-5; %ev/K
e = 1.60218 *10^-19; % Coloumbs
T = 293; %K
n = 2;
R = 8.314; %J/molK
F = 96485; %A*s/mol
eta = 0:0.001:N; %V overpotential
EaV = 0.15; %eV Volmer Activation Energy
jL = 100; %A/cm^2 mass transport limiting current
%Butler-Volmer with alpha = 0.48
%{
%Norskov 2005
delGh = @(delEh) delEh + 0.24; %Delta G of H adsoprtion
theta = @(K) K/(1+K); %Fractional coverage of Metal
K = @(delGh,T) -delGh/(kB*T);
k0 = 200; % 1/(s*sites)
%}

%Skulason_2007 (DFT numbers)
SA = 6.64*10^-16; %cm^2/atom
v = 7.55*10^12; %10^13; %1/(s*sites); prefactor -this value is sketchy
%Tafel Mechanism
EaT = 0.8; %Tafel Reaction eV
koT = v*exp(-(EaT+EaV)/(kB*T));
joT = koT*2*e/SA;
alphaT = .36; %anodic transfer coefficient
jKT = joT*(exp(2*alphaT*F/(R*T)*eta)-exp(-2*(1-alphaT)*F/(R*T)*eta)); %kinetic current density
jfT = joT*(exp(2*alphaT*F/(R*T)*eta)); %kinetic current of forward reaction
jVBT = jKT./(1+jfT/jL);
%Heyrovsky Mechanism
EaH = 0.6; % Reaction eV
koH = v*exp(-(EaH+EaV)/(kB*T));
joH = koH*2*e/SA;
alphaH = .52; %anodic transfer coefficient
jKH = joH*(exp(2*alphaH*F/(R*T)*eta)-exp(-2*(1-alphaH)*F/(R*T)*eta)); %kinetic current density
jfH = joH*(exp(2*alphaH*F/(R*T)*eta)); %kinetic current of forward reaction
jVBH = jKH./(1+jfH/jL);

%Rheinlander 2014 (Experimental)
alphaE = 0.48;
joE = 0.55*10^-3;
jKE = joE*(exp(2*alphaE*F/(R*T)*eta)-exp(-2*(1-alphaE)*F/(R*T)*eta)); %kinetic current density
jfE = joE*(exp(2*alphaE*F/(R*T)*eta)); %kinetic current of forward reaction
jVBE = jKE./(1+jfE/jL);




figure(3)
plot(eta,jVBE,eta,jVBT,eta,jVBH);
xlabel('Overpotential (V)');
ylabel('Current density (A/cm^2)');
legend('Experimental Fit','DFT-Tafel','DFT-Heyrovsky')
title('Current Density with limiting current of 100 A')
ylim([0 125])
xlim([0 1])
