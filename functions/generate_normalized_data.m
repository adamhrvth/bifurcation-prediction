clc, clear all;

% making transformator functions available
addpath('./transformators');



%% options and descriptions for file saving
savedFileName = "sys2_c1_0_1_c3_0_1_1_9_IC_0_7_4_1600samples_polar";
savedFileFolder = "..\resources\data\simulation\normalized";



%% load simulation results
loadedFileFolder = '..\resources\data\';
loadedDataOrigin = 'simulation';
loadedFilename = 'sys2_c1_0_1_c3_0_1_1_9_IC_0_7_4_1600samples.mat';

load(fullfile(loadedFileFolder, loadedDataOrigin, "raw", loadedFilename));

x = data.x;
meta = data.meta;



%% normalization

% calculate rho for each series
rho = zeros(size(x, 1), size(x, 3));

for i = 1 : size(x, 3)
    
    rho(:, i) = normalizeSeries("max +1", ...
                    normalizeSeries("polar", x(:, 1, i), x(:, 2, i)) ...
                  );
end



%% extend metadata
meta.normalization = "polar transformation and then setting the maximum to be 1";



%% save normalized simulation results
clear data;

data.rho = rho;
data.meta = meta;

save(fullfile(savedFileFolder, savedFileName), "data");


