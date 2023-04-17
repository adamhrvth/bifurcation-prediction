clc, clear all;



%% options and descriptions for file saving
savedFileName = "sys2_c1_0_1_c3_0_5_1_5_IC_0_7_2_1600samples_t_500.mat";

savedFileForder = "..\resources\data\simulation\raw";



%% generating training data

% parameters
c1 = 0.1;
% c3Crit = -10 / 9 * sqrt(2*c1) * 1.34;       % System 2
c3Crit = 40 / 9 * c1;                     % System 1
c3Range = [0.5, 1.5] * c3Crit;

% initial value points
x0Range = [0.7, 2];

% number of distinct c_3 parameter points, initial value pairs
paramPoints = 40;
initPoints = 40;

tspan = 0:0.5:500;

[t, x] = runSimulation(@system_dyn_2_fun, c1, c3Range, x0Range, paramPoints, initPoints, tspan);



%% generating metadata for the saved file
meta.dataStructure = "matrix";
meta.type = "simulation data";
meta.system = "System 2";
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


