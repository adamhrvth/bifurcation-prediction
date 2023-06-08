% before running this script, run
% "train_meas_LSTM_sequence".m or load a validation data
% set like "measurement_data_set_absamp_norm_10800_samples.mat"

%% load trained NN
netStruct = load('net_meas_HU50_0_8_absamp_norm_10800_samples.mat', "net");
dataStruct = data;


%% load validation data
dataset = load('measurement_data_set_absamp_norm_10800_samples.mat');
TValidation = dataset.data.TValidation;
XValidation = dataset.data.XValidation;

%% make the prediction using the obtained NN on the validation data set
YPred = cell(length(TValidation), 1);

for i = 1 : length(TValidation)
    YPred{i} = classify(netStruct.net, XValidation{i});
end

%% calculate erroneous number of labels
totalLength = 0;
erroneousVals = 0;

for i = 1 : length(TValidation)
    totalLength = totalLength + length(XValidation{i});
    curr = YPred{i};
    erroneousVals = erroneousVals + numel(curr(curr ~= TValidation{i}));
end

err = erroneousVals / totalLength * 100;


