clc, clear all;

load("flutter_system_pars");


% close: 0.801 - 0.811 (extend or  shrink it)
uBefore = linspace(0.4, 0.65, 20);

uClose = linspace(0.801, 0.811, 20);

uAfter = linspace(0.82, 0.9, 20);
u = [uBefore, uClose, uAfter];

par = cell(60, 1);

for i = 1:60
    par{i} = getPars(u(i));
end


% initial condition
y0Start = 2; y0End = 3;
alpha0Start = 2; alpha0End = 3;
xtilde0Start = -2; xtilde0End = -3;

x0=[linspace(y0Start, y0End, 10), linspace(y0End, y0Start, 10),... 
    linspace(y0Start, y0End, 10), linspace(y0Start, y0End, 10);...

    linspace(alpha0Start, alpha0End, 10), linspace(alpha0Start, alpha0End, 10),...
    linspace(alpha0End, alpha0Start, 10), linspace(alpha0Start, alpha0End, 10);...

    linspace(xtilde0Start, xtilde0End, 10), linspace(xtilde0Start, xtilde0End, 10),...
    linspace(xtilde0Start, xtilde0End, 10), linspace(xtilde0End, xtilde0Start, 10);...

    zeros(1, 40);...
    zeros(1, 40);...
    zeros(1, 40)];

% final time
timeIncrement = 0.025;
tspan=0:timeIncrement:500;



% simulation
option=odeset('RelTol', 1e-6, 'AbsTol', 1e-8);

t = cell(60*40, 1);
x = cell(60*40, 1);

for i = 1 : 60
    for j = 1 : 40
        ind = (i-1)*40 + j;
        [t{ind}, x{ind}] = ode45(@(t,xt) system_PaP(t,xt,par{i}), tspan, x0(:, j), option);
    end
end

data.meta.system = "aeroelastic system";
data.meta.velocityRegions = {uBefore; uClose; uAfter};
data.meta.classificationLabels = {"before bifurcation", "close to bifurcation", "after bifurcation"};
data.meta.velocityRegionsPoints = {20; 20; 20};
data.meta.initPoints = 40;
data.meta.initialPointsRange = {[y0Start y0End]; [alpha0Start; alpha0End]; [xtilde0Start; xtilde0End]};
data.meta.timeIncrement = timeIncrement;

data.t = t;
data.x = x;

save("flutter_sim_data_tspan_fixed.mat", "data");
