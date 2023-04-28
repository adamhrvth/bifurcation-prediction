clc, clear all;

% network file to be saved
networkFileFolder = "..\..\results\networks\trained_autoencoder";
networkFileName = "conv_autoencoder_system1_extendedICs_before.mat";



%% load training data set
% load series
seriesFileName = "sys1_c1_0_5_c3_0_05_0_98_IC_0_7_5_1600samples_minmax_cell";
seriesFileFolder = "..\..\resources\data\simulation\normalized";

series = load(fullfile(seriesFileFolder, seriesFileName));

rho = series.data.rho;
meta = series.data.meta;



%% truncate data
numDownsamples = 2;

sequenceLengths = zeros(1, numel(rho));

for n = 1 : numel(rho)
    X = rho{n};
    cropping = mod(size(X,2), 2^numDownsamples);
    X(:, end-cropping + 1 : end) = [];
    rho{n} = X;
    sequenceLengths(n) = size(X,2);
end



%% setup layers
numChannels = 1;

filterSize = 20;
numFilters = 64;

dropoutProb = 0.3;

minLength = min(sequenceLengths);

layers = sequenceInputLayer(numChannels, MinLength=minLength);

for i = 1 : numDownsamples
    layers = [
        layers
        convolution1dLayer(filterSize, (numDownsamples + 1 - i)*numFilters, Padding="same", Stride = 2)
        reluLayer];
        %dropoutLayer(dropoutProb)];
end

for i = 1 : numDownsamples
    layers = [
        layers
        transposedConv1dLayer(filterSize, i*numFilters, Cropping="same", Stride = 2)
        reluLayer];
        %dropoutLayer(dropoutProb)];
end

layers = [
    layers
    transposedConv1dLayer(filterSize,numChannels, Cropping="same")
    regressionLayer];



%% specify training options
miniBatchSize = 32;
maxEpochs = 100;

options = trainingOptions("adam", ...
    MiniBatchSize = miniBatchSize, ...
    MaxEpochs=maxEpochs, ...
    Shuffle="every-epoch", ...
    Verbose=0, ...
    Plots="training-progress");



%% train network
net = trainNetwork(rho, rho, layers, options);



%% save the network
clear data;

data.net = net;

data.meta.trainingData = meta;
data.meta.trainingData.miniBatchSize = miniBatchSize;
data.meta.trainingData.maxEpochs = maxEpochs;

data.meta.networkDetails.type = "Convolutional autoencoder neural network";
data.meta.networkDetails.numberOfDownSamples = numDownsamples;

save(fullfile(networkFileFolder, networkFileName), "data");



