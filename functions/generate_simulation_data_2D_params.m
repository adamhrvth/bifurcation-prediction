clc, clear all;

addpath("./systems");

%% options and descriptions for file saving
savedFileName = "sys1_2Dparams_c1_0_8_1_2_c3_1_5_1_8_ICfixed_1_1_1600samples.mat";

savedFileForder = "..\resources\data\simulation\raw";



%% generating training data

% number of distinct parameter points
paramPoints = 40;

% parameters
c1 = 1;
c1Range = linspace(0.8, 1.2, paramPoints);
%c3Crit = -10 / 9 * sqrt(2*c1) * 1.34;       % System 2
c3Crit = 40 / 9 * c1;                     % System 1
c3Range = linspace(1.5, 1.8, paramPoints) * c3Crit;

% initial value points
x0 = [1 1];

tspan = 0:0.1:100;

t = zeros(length(tspan), 1, paramPoints^2);
x = zeros(length(tspan), 2, paramPoints^2);

% calculate solutions for each parameter value and initial condition pair
for i = 1:paramPoints
    for j = 1:paramPoints

        ind = (i - 1) * paramPoints + j;
        [t(:, 1, ind), x(:, :, ind)] = getTimeSeries(@system_dyn_fun, [c1Range(i) c3Range(j)], tspan, x0);

    end
end



%% generating metadata for the saved file
meta.dataStructure = "matrix";
meta.type = "simulation data";
meta.system = "System 1";
meta.parameterDomain = "2D";
meta.parameters = "c1Relative ranging between 0.8 and 1.2, c3Relative between 0.2 and 0.5";
meta.c1FixedForc3CritCalc = c1;
meta.c1Range = c1Range;
meta.c3Relative = [min(c3Range)/c3Crit, max(c3Range)/c3Crit];
meta.c3 = c3Range;
meta.x0Information = "initial conditions are fixed, not ranging between values";
meta.x0 = x0;
meta.paramPoints = paramPoints;



%% save simulation results
data.t = t;
data.x = x;
data.meta = meta;
save(fullfile(savedFileForder, savedFileName), "data");


