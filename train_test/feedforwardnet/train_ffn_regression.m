clc, clear all;

networkFileFolder = "..\..\results\networks\trained_feedforwardnet";
networkFileName = "ffn_advanced_sys1_absamp_c1_0_5_c3_0_5_1_5_IC_0_7_2_1600samples.mat";



%% load training data set
% load series
seriesFileName = "sys1_c1_0_5_c3_0_5_1_5_IC_0_7_2_1600samples_minmax.mat";
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
% train ffn network with hidden layer dims [15 20 20 10]
hiddenLayerDims = [15 20 20 10];
[net, tr] = trainFeedForward(hiddenLayerDims, rho, targetValues);



%% save the network
clear data;
data.net = net;

data.meta.trainingData = meta;

data.meta.networkDetails.type = "feedforward neural network";
data.meta.networkDetails.dimensions = hiddenLayerDims;

save(fullfile(networkFileFolder, networkFileName), "data");


