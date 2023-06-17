clc, clear all;



%% options and descriptions for file saving
savedFileName = "ternary_labels_1500_samples_vanderpol_forvaryingICs.mat";

dataStructure = "categorical array";
dataType = "label";
rangeOfValues = "'before', 'close' or 'after'";



%% generate expected output
numberOfSamples = 150*10;
targetValues = strings(numberOfSamples, 1);

for i = 1:10
    top = (i-1)*150;
    targetValues(top + (1:50), 1) = "before";
    targetValues(top + (51:100), 1) = "close";
    targetValues(top + (101:150), 1) = "after";
end

targetValues = categorical(targetValues);



%% save the values and the metadata
clear data;

data.meta.dataStructure = dataStructure;
data.meta.type = dataType;
data.meta.rangeOfValues = rangeOfValues;
data.meta.numberOfSamples = numberOfSamples;
data.meta.numberOfClasses = {"50*10"; "50*10"; "50*10"};

data.targetValues = targetValues;

save(savedFileName, "data");


