clc, clear all;



%% load network
networkFileName = "polar_log_trained_x1_mvn_avg";
% networkFileName = "polar_log_trained_y_mvn_avg";
% networkFileName = "mixed_polar_log_mvn_avg_trained";
% networkFileName = "polar_log_trained_y_mvn_avg.mat";
% networkFileName = "polar_log_trained_sys1_c1_0_5_mvn_avg";
% networkFileName = "polar_log_trained_sys1_c1_0_5_mvn_avg";

network = load(networkFileName);

net = network.data.net;



%% load testing data set
% seriesFileName = "vanderpol_x1_varyingICs_polar_log";
seriesFileName = "../vanderpol_data/xt_polar_log";
% seriesFileName = "raw_sections_of_measurements_0516_transformed_mvn_avg";
% seriesFileName = "alpha_polar_log_mvn_avg";
% seriesFileName = "sys1_c1_1_c3_3ranges_IC_0_7_4_1600samples_polar_log_mvn_avg";
% seriesFileName = "sys2_c1_0_3_c3_3ranges_IC_0_7_4_1600samples_polar_log_mvn_avg"; %consultation

series = load(seriesFileName);

rho = series.data.rho;

%% load expected outputs
targetFileName = "../vanderpol_data/ternary_labels_1500_samples_vanderpol_forvaryingICs.mat";
% targetFileName = "ternary_labels_1600_samples.mat";
% targetFileName = "ternary_labels_3233_samples_mixed.mat";

targets = load( targetFileName);

targetValues = targets.data.targetValues;


%% testing - regression using the obtained network
pred = classify(net, rho);

error = numel(pred(pred ~= targetValues))/length(pred) * 100;

disp("error:");
disp(error)