clc, clear all;



%% options and descriptions for file saving
% [0.1 0.5] [0.98 0.999] [1.01 1.5] 
savedFileName = "sys1_c1_0_5_c3_3ranges_IC_0_7_2_1600samples.mat";

savedFileForder = "..\resources\data\simulation\raw";



%% generating training data

% parameters
c1 = 0.5;
% c3Crit = -10 / 9 * sqrt(2*c1) * 1.34;       % System 2
c3Crit = 40 / 9 * c1;                     % System 1
c3RangeStable = [0.1, 0.5] * c3Crit;
c3RangeClose = [0.98, 0.99] * c3Crit;
c3RangeBif = [1.01, 1.5] * c3Crit;

% initial value points
x0Range = [0.7, 2];

% number of distinct c_3 parameter points, initial value pairs
paramPointsStable = 13;
paramPointsClose = 14;
paramPointsBif = 13;
initPoints = 40;

tspan = 0:0.1:100;

[tS, xS] = runSimulation(@system_dyn_fun, c1, c3RangeStable, x0Range, paramPointsStable, initPoints, tspan);
[tC, xC] = runSimulation(@system_dyn_fun, c1, c3RangeClose, x0Range, paramPointsClose, initPoints, tspan);
[tB, xB] = runSimulation(@system_dyn_fun, c1, c3RangeBif, x0Range, paramPointsBif, initPoints, tspan);



%% generating metadata for the saved file
meta.dataStructure = "matrix";
meta.type = "simulation data";
meta.system = "System 1";
meta.c1 = c1;
meta.dataLabels = {"no bifurcation"; "close"; "bifurcation"};
meta.c3Relative = {[min(c3RangeStable)/c3Crit, max(c3RangeStable)/c3Crit];...
                   [min(c3RangeClose)/c3Crit, max(c3RangeClose)/c3Crit];...
                   [min(c3RangeBif)/c3Crit, max(c3RangeBif)/c3Crit]};
meta.c3 = {c3RangeStable;...
           c3RangeClose;...
           c3RangeBif};
meta.x0 = x0Range;
meta.paramPoints = {paramPointsStable;...
                    paramPointsClose;...
                    paramPointsBif};
meta.initPoints = initPoints;



%% save simulation results
data.t.tStable = tS;
data.x.xStable = xS;

data.t.tClose = tC;
data.x.xClose = xC;

data.t.tBif = tB;
data.x.xBif = xB;

data.meta = meta;

save(fullfile(savedFileForder, savedFileName), "data");

