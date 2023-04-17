clc, clear all;



%% load simulation results in matrix format
seriesFileName = "sys2_c1_0_3_c3_0_1_1_9_IC_0_7_2_1600samples_polar";
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
