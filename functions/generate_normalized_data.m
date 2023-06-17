clc, clear all;

% making transformator functions available
addpath('./transformators');



%% load simulation results
loadedFileFolder = '..\resources\data\';
loadedDataOrigin = 'simulation';
loadedFileName = 'sys1_c1_0_5_c3_0_2_IC_0_7_2_1600samples_noisy';

load(fullfile(loadedFileFolder, loadedDataOrigin, "raw", loadedFileName));

x = data.x;
meta = data.meta;



%% options and descriptions for file saving
savedFileName = strcat(loadedFileName, "_polar_log");
savedFileFolder = "..\resources\data\simulation\normalized";



%% normalization

% calculate rho for each series
rho = zeros(size(x, 1), size(x, 3));

for i = 1 : size(x, 3)
    
    rho(:, i) = log(normalizeSeries("max +1" ,normalizeSeries("polar", x(:, 1, i), x(:, 2, i))));

end



%% extend metadata
meta.normalization = "polar transformation and then setting the maximum to be 1, taking the logarithm of the series after that";



%% save normalized simulation results
clear data;

data.rho = rho;
data.meta = meta;

save(fullfile(savedFileFolder, savedFileName), "data");


