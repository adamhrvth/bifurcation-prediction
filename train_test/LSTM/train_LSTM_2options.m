clc, clear all;

% network file to be saved
networkFileFolder = "..\..\results\networks\trained_LSTM";
networkFileName = "LSTM_sys1_minmax_c1_0_5_c3_0_5_1_5_IC_0_7_2_1600samples.mat";



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
numHiddenUnits = 25;
numClasses = numel(unique(targetClassification));
miniBatchSize = 32;

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(numHiddenUnits, OutputMode = "last")
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 50;
initialLearnRate = 0.0001;

options = trainingOptions("adam", ...
    MaxEpochs = maxEpochs, ...
    InitialLearnRate = initialLearnRate, ...
    MiniBatchSize = miniBatchSize,...
    Plots = "training-progress", ...
    Verbose = false);



%% train network
net = trainNetwork(rho, targetClassification, layers, options);



%% save the network
clear data;

data.net = net;

data.meta.trainingData = meta;
data.meta.trainingData.miniBatchSize = miniBatchSize;
data.meta.trainingData.initialLearnRate = initialLearnRate;
data.meta.trainingData.maxEpochs = maxEpochs;

data.meta.networkDetails.type = "LSTM recurrent neural network";
data.meta.networkDetails.numberOfLSTMLayers = 1;
data.meta.networkDetails.hiddenUnits = [ numHiddenUnits ];

save(fullfile(networkFileFolder, networkFileName), "data");


