clc, clear all;

% making transformator functions available
addpath('./transformators');



%% load simulation results
loadedFileFolder = '..\resources\data\';
loadedDataOrigin = 'simulation';
loadedFileName = 'sys1_2Dparams_c1_0_8_1_2_c3_1_5_1_8_ICfixed_1_1_1600samples';

load(fullfile(loadedFileFolder, loadedDataOrigin, "raw", loadedFileName));

x = data.x;
meta = data.meta;



%% options and descriptions for file saving
savedFileName = strcat(loadedFileName, "_minmax");
savedFileFolder = "..\resources\data\simulation\normalized";



%% normalization

% calculate rho for each series
rho = zeros(size(x, 1), size(x, 3));

for i = 1 : size(x, 3)
    
    rho(:, i) = normalizeSeries("-1 to +1", x(:, 1, i));

end



%% extend metadata
meta.normalization = "normalizing the displacement to be between -1 and +1";



%% save normalized simulation results
clear data;

data.rho = rho;
data.meta = meta;

save(fullfile(savedFileFolder, savedFileName), "data");


