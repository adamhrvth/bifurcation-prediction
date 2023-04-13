clc, clear all;

networkFileFolder = "..\..\results\networks\trained_feedforwardnet";
networkFileName = "ffn_sys1_polar_c1_0_5_1600samples.mat";



%% load training data set
% load series
seriesFileName = "sys1_c1_0_5_c3_0_5_1_5_polar_normalized.mat";
seriesFileFolder = "..\..\resources\data\simulation\normalized";

series = load(fullfile(seriesFileFolder, seriesFileName));

rho = series.data.rho;
meta = series.data.meta;

% load expected output
targetFileName = "expected_output_0_1_1600_samples.mat";
targetFileFolder = "..\..\resources\targets";
targetClass = "regression";

targets = load(fullfile(targetFileFolder, targetClass, targetFileName));
targetValues = targets.data.targetValues;



%% network training
% train ffn network with hidden layer dims [10 20 10]
[net, tr] = trainFeedForward([10 20 10], rho, targetValues);



%% save the network
clear data;
data.net = net;

data.meta.trainingData = meta;

data.meta.networkDetails.type = "feedforward neural network";
data.meta.networkDetails.dimensions = [10, 20, 10];

save(fullfile(networkFileFolder, networkFileName), "data");


