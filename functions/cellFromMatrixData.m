clc, clear all;



%% load simulation results in matrix format
seriesFileName = "sys1_2Dparams_c1_0_8_1_2_c3_1_5_1_8_ICfixed_1_1_1600samples_minmax";
seriesFileFolder = "..\resources\data\simulation\normalized";

series = load(fullfile(seriesFileFolder, seriesFileName));



%% modify data
rho = cell(size(series.data.rho, 2), 1);

for i = 1 : size(series.data.rho, 2)
    rho{i} = series.data.rho(:, i)';
end

%% save data
data.rho = rho;
data.meta = series.data.meta;
% modify metadata
data.meta.dataStructure = "cell";

save(fullfile(seriesFileFolder, strcat(seriesFileName, "_cell")), "data");
