clc, clear all;



%% options and descriptions for file saving
savedFileName = "ternary_labels_1600_samples.mat";

savedDataFolder = "..\resources\targets";
savedDataClass = "classification";

dataStructure = "categorical array";
dataType = "label";
rangeOfValues = "'before', 'close' or 'after'";



%% generate expected output
numberOfSamples = 1600;
targetValues = strings(numberOfSamples, 1);

targetValues(1:13*40, 1) = "before";
targetValues(13*40+1:(13+14)*40, 1) = "close";
targetValues((13+14)*40+1:1600, 1) = "after";

targetValues = categorical(targetValues);


%% save the values and the metadata
clear data;

data.meta.dataStructure = dataStructure;
data.meta.type = dataType;
data.meta.rangeOfValues = rangeOfValues;
data.meta.numberOfSamples = numberOfSamples;
data.meta.numberOfClasses = {"13*40"; "14*40"; "13*40"};

data.targetValues = targetValues;

save(fullfile(savedDataFolder, savedDataClass, savedFileName), "data");


