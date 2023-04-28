clc, clear all;



%% load network
networkFileName = "CONVnet_sys1_polar_3options_c1_0_5_IC_0_7_2_1600samples.mat";
networkFolderName = "..\..\results\networks\trained_";
networkClass = "CONVnet";

network = load(fullfile(strcat(networkFolderName, networkClass), networkFileName));

net = network.data.net;



%% load testing data set
seriesFileName = "sys1_c1_1_c3_3ranges_IC_0_7_4_1600samples_polar.mat";
seriesFileFolder = "..\..\resources\data\simulation\normalized";

series = load(fullfile(seriesFileFolder, seriesFileName));

rho = series.data.rho;



%% load expected outputs
targetFileName = "ternary_labels_1600_samples.mat";
targetFileFolder = "..\..\resources\targets\classification";

targets = load(fullfile(targetFileFolder, targetFileName));

targetValues = targets.data.targetValues;



%% testing - regression using the obtained network
pred = classify(net, rho);

error = numel(pred(pred ~= targetValues))/length(pred) * 100;

disp("error:");
disp(error)