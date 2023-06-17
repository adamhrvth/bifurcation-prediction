clc, clear all;

% network file to be saved
networkFileName = "polar_log_trained_x1_mvn_avg.mat";



%% load training data set
% load series
seriesFileName = "../vanderpol_data/vanderpol_x1_varyingICs_polar_log_mvn_avg";

series = load(seriesFileName);

rho = series.data.rho';
meta = series.data.meta;



%% load targetclassification
targetFileName = "../vanderpol_data/ternary_labels_1500_samples_vanderpol_forvaryingICs.mat";

targets = load(targetFileName);
targetClassification = targets.data.targetValues;



%% Setup layers
inputSize = 1;
numClasses = numel(unique(targetClassification));
miniBatchSize = 32;

filterSize = 20;
numFilters = 32;

layers = [ ...
    sequenceInputLayer(inputSize)
    convolution1dLayer(filterSize, numFilters, Padding="causal")
    reluLayer
%     dropoutLayer(0.3)
    layerNormalizationLayer
    convolution1dLayer(filterSize, 2*numFilters, Padding="causal")
    reluLayer
%     dropoutLayer(0.3)
    layerNormalizationLayer
    globalAveragePooling1dLayer
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 40;
% initialLearnRate = 0.001;

options = trainingOptions("adam", ...
    MiniBatchSize = miniBatchSize, ...
    MaxEpochs = maxEpochs, ...
    SequencePaddingDirection = "left", ...
    Plots="training-progress", ...
    Verbose=0);

%% train network
net = trainNetwork(rho, targetClassification, layers, options);



%% save the network
clear data;

data.net = net;

data.meta.trainingData = meta;
data.meta.trainingData.miniBatchSize = miniBatchSize;
data.meta.trainingData.maxEpochs = maxEpochs;

data.meta.networkDetails.type = "Convolutional neural network";
data.meta.networkDetails.numberOfCONVLayers = 2;
data.meta.networkDetails.filterSizeLayer1 = filterSize;
data.meta.networkDetails.filterSizeLayer2 = filterSize;
data.meta.networkDetails.numFiltersLayer1 = numFilters;
data.meta.networkDetails.numFiltersLayer2 = 2*numFilters;

save(networkFileName, "data");

