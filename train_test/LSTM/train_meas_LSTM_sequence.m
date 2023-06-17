clc, clear all;



%% Load data
load ("../../resources/data/measurement/processedData_EqualNumber_NormalizedMinMax_ABS_sequence.mat");



numObservations = numel(data.displacement);

% shuffle the data set
[idxTrain, idxValidation] = trainingPartitions(numObservations, [0.8 0.2]);

XTrain = data.displacement(idxTrain);
XValidation = data.displacement(idxValidation);

TTrain = data.classification(idxTrain);
TValidation = data.classification(idxValidation);



%% Setup layers
numFeatures = 1;
numHiddenUnits = 50;
numClasses = 2;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','sequence')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

options = trainingOptions('adam', ...
    'MaxEpochs',50, ...
    'GradientThreshold',2, ...
    'Verbose',0, ...
    'Plots','training-progress');

net = trainNetwork(XTrain, TTrain, layers, options);



save("../../results/networks/trained_LSTM/LSTM_meas_HU50_0_8_absamp_norm_10800_samples", "net");


