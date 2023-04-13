clc, clear all;



%% options and descriptions for file saving
savedFileName = "expected_output_0_1_1600_samples.mat";

savedDataFolder = "..\resources\targets";
savedDataClass = "regression";

dataStructure = "matrix";
dataType = "numeric";
rangeOfValues = "only 0 or 1";



%% load training time series
loadedDataFolder = "..\resources\data\simulation";
loadedDataClass = "normalized";
loadedFileName = "sys1_c1_0_5_c3_0_5_1_5_polar_normalized.mat";

load(fullfile(loadedDataFolder, loadedDataClass, loadedFileName));

% total number of series
numberOfSamples = data.meta.paramPoints * data.meta.initPoints;



%% generate expected output
targetValues = [zeros(1, numberOfSamples/2), ones(1, numberOfSamples/2)];



%% save the values and the metadata
clear data;

data.meta.dataStructure = dataStructure;
data.meta.type = dataType;
data.meta.rangeOfValues = rangeOfValues;
data.meta.numberOfSamples = numberOfSamples;

data.targetValues = targetValues;

save(fullfile(savedDataFolder, savedDataClass, savedFileName), "data");


