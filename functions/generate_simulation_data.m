clc, clear all;



%% options and descriptions for file saving
savedFileName = "sys1_c1_0_5_c3_0_05_0_98_IC_0_7_5_1600samples.mat";

savedFileForder = "..\resources\data\simulation\raw";



%% generating training data

% parameters
c1 = 0.5;
%c3Crit = -10 / 9 * sqrt(2*c1) * 1.34;       % System 2
c3Crit = 40 / 9 * c1;                     % System 1
c3Range = [0.05, 0.98] * c3Crit;

% initial value points
x0Range = [0.7, 5];

% number of distinct c_3 parameter points, initial value pairs
paramPoints = 40;
initPoints = 40;

tspan = 0:0.1:100;

[t, x] = runSimulation(@system_dyn_fun, c1, c3Range, x0Range, paramPoints, initPoints, tspan);



%% generating metadata for the saved file
meta.dataStructure = "matrix";
meta.type = "simulation data";
meta.system = "System 1";
meta.c1 = c1;
meta.c3Relative = [min(c3Range)/c3Crit, max(c3Range)/c3Crit];
meta.c3 = c3Range;
meta.x0 = x0Range;
meta.paramPoints = paramPoints;
meta.initPoints = initPoints;



%% save simulation results
data.t = t;
data.x = x;
data.meta = meta;
save(fullfile(savedFileForder, savedFileName), "data");


