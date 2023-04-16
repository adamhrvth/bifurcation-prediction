clc, clear all;

% making transformator functions available
addpath('./transformators');



%% load simulation results
loadedFileFolder = '..\resources\data\';
loadedDataOrigin = 'simulation';
loadedFileName = 'sys2_c1_0_3_c3_0_1_1_9_IC_0_7_2_1600samples';

load(fullfile(loadedFileFolder, loadedDataOrigin, "raw", loadedFileName));

x = data.x;
meta = data.meta;



%% options and descriptions for file saving
savedFileName = strcat(loadedFileName, "_absamp");
savedFileFolder = "..\resources\data\simulation\normalized";



%% normalization

% calculate rho for each series
rho = zeros(size(x, 1), size(x, 3));

for i = 1 : size(x, 3)
    
    rho(:, i) = normalizeSeries("abs -1 to +1", x(:, 1, i));

end



%% extend metadata
meta.normalization = "normalizing the absolute amplitudes to be between -1 and +1";



%% save normalized simulation results
clear data;

data.rho = rho;
data.meta = meta;

save(fullfile(savedFileFolder, savedFileName), "data");


