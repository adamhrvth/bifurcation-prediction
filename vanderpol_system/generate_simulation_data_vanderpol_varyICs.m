clc, clear all;

% x0 = [0.25 0 0 0];
x0 =[1 1 1 1;...
     1 1 2 2;...
     1 2 1 1;...
     2 2 1 1;...
     1 2 0 0;...
     2 1 0 0;...
     2 0 0 0;...
     2 0 1 1;...
     0 2 1 1;...
     0 2 0 0];
t0 = 0;
tfinal = 500;
tincrement = 0.05;
tspan = t0 : tincrement : tfinal;

option=odeset('RelTol', 1e-10, 'AbsTol', 1e-10);



% ========================== Parameter Definitions ===================
epsilon=0.05;
gamma=0.97;

% mu_1crit = 0.1005, start of coexistence of sols.: mu_1 = 0.0619
muBefore = linspace(0, 0.025, 50);
muClose = linspace(0.059, 0.0605, 50);
% muClose = linspace(0.0857, 0.0898, 50);   % for x0 = [0.25 0 0 0]
muAfter = linspace(0.062, 0.07, 50);
%muAfter = linspace(0.1005, 0.12, 50);      % for x0 = [0.25 0 0 0]
mu1 = [muBefore, muClose, muAfter];
mu2=0.12;

alpha3=0.3;
beta2=0;
beta3=0;



t = cell(size(x0, 1) * 150, 1);
x = cell(size(x0, 1) * 150, 1);

for j = 1 : size(x0, 1)
    for i = 1 : 150

        ind = (j - 1) * 150 + i;
        [t{ind}, x{ind}] = ode45(@(t,x) system1(t, x, epsilon, gamma, mu1(i), mu2, alpha3, beta2, beta3),...
                               tspan, x0(j, :), option);
    
    end
end

data.meta.system = "Van der Pol oscillator";
data.meta.muRegions = {muBefore; muClose; muAfter};
data.meta.classificationLabels = {"before bifurcation", "close to bifurcation", "after bifurcation"};
data.meta.muRegionsPoints = {50; 50; 50};
data.meta.initialConditions = x0;
data.meta.timeIncrement = tincrement;

data.t = t;
data.x = x;

save("vanderpol_sim_data_tspan_fixed_varyingICs.mat", "data");


