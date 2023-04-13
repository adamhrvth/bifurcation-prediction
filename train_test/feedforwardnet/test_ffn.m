clc, clear all;

% making calcRMS available
addpath("..\..\functions\error_computation");


%% load network
networkFileName = "ffn_sys1_polar_c1_0_5_c3_0_5_1_5_IC_0_7_2_1600samples.mat";
networkFolderName = "..\..\results\networks\trained_";
networkClass = "feedforwardnet";

network = load(fullfile(strcat(networkFolderName, networkClass), networkFileName));

net = network.data.net;



%% load testing data set
seriesFileName = "sys1_c1_1_c3_0_1_1_9_IC_0_7_4_1600samples_polar.mat";
seriesFileFolder = "..\..\resources\data\simulation\normalized";

series = load(fullfile(seriesFileFolder, seriesFileName));

rho = series.data.rho;



%% load expected outputs
targetFileName = "expected_output_0_1_1600_samples.mat";
targetFileFolder = "..\..\resources\targets\regression";

targets = load(fullfile(targetFileFolder, targetFileName));

targetValues = targets.data.targetValues;



%% testing - regression using the obtained network
pred = net(rho);

RMS = calcRMS(pred, targetValues);

disp("RMS error:");
disp(RMS*100)


