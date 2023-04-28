clc, clear all;

% network file to be saved
networkFileFolder = "..\..\results\networks\trained_CONVnet";
networkFileName = "CONVnet_sys1_minmax_c1_0_5_c3_0_5_1_5_IC_0_7_2_1600samples.mat";



%% load training data set
% load series
seriesFileName = "sys1_c1_0_5_c3_0_5_1_5_IC_0_7_2_1600samples_minmax_cell.mat";
seriesFileFolder = "..\..\resources\data\simulation\normalized";

series = load(fullfile(seriesFileFolder, seriesFileName));

rho = series.data.rho;
meta = series.data.meta;



%% load targetclassification
targetFileName = "binary_labels_1600_samples.mat";
targetFileFolder = "..\..\resources\targets";
targetClass = "classification";

targets = load(fullfile(targetFileFolder, targetClass, targetFileName));
targetClassification = targets.data.targetValues;



%% Setup layers
inputSize = 1;
numClasses = 2;
miniBatchSize = 32;

filterSize = 20;
numFilters = 32;

layers = [ ...
    sequenceInputLayer(inputSize)
    convolution1dLayer(filterSize, numFilters, Padding="causal")
    reluLayer
    layerNormalizationLayer
    convolution1dLayer(filterSize, 2*numFilters, Padding="causal")
    reluLayer
    layerNormalizationLayer
    globalAveragePooling1dLayer
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 50;
initialLearnRate = 0.001;

options = trainingOptions("adam", ...
    MiniBatchSize = miniBatchSize, ...
    MaxEpochs = maxEpochs, ...
    SequencePaddingDirection = "left", ...
    InitialLearnRate = initialLearnRate, ...
    Plots="training-progress", ...
    Verbose=0);

%% train network
net = trainNetwork(rho, targetClassification, layers, options);



%% save the network
clear data;

data.net = net;

data.meta.trainingData = meta;
data.meta.trainingData.miniBatchSize = miniBatchSize;
data.meta.trainingData.initialLearnRate = initialLearnRate;
data.meta.trainingData.maxEpochs = maxEpochs;

data.meta.networkDetails.type = "Convolutional neural network";
data.meta.networkDetails.numberOfCONVLayers = 2;
data.meta.networkDetails.filterSizeLayer1 = filterSize;
data.meta.networkDetails.filterSizeLayer2 = filterSize;
data.meta.networkDetails.numFiltersLayer1 = numFilters;
data.meta.networkDetails.numFiltersLayer2 = 2*numFilters;

save(fullfile(networkFileFolder, networkFileName), "data");

