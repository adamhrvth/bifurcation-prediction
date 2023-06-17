clc, clear all;



%% options and descriptions for file saving
savedFileName = "ternary_labels_3233_samples_mixed.mat";

dataStructure = "categorical array";
dataType = "label";
rangeOfValues = "'before', 'close' or 'after'";



%% generate expected output
numberOfSamples = 2400;
targetValues = strings(numberOfSamples, 1);

% simulation
targetValues(1:20*40, 1) = "before";
targetValues(20*40+1:40*40, 1) = "close";
targetValues(40*40+1:60*40, 1) = "after";
% measurement
targetValues(2400 + 1 : 2400 + 207, 1) = "before";
targetValues(2400 + 208 : 2400 + 297, 1) = "close";
targetValues(2400 + 298 : 2400 + 833, 1) = "after";

targetValues = categorical(targetValues);


%% save the values and the metadata
clear data;

data.meta.dataStructure = dataStructure;
data.meta.type = dataType;
data.meta.rangeOfValues = rangeOfValues;
data.meta.numberOfSamples = numberOfSamples;
data.meta.numberOfClasses = {"20*40 + 207"; "20*40 + 89"; "20*40 + 536"};

data.targetValues = targetValues;

save(savedFileName, "data");


