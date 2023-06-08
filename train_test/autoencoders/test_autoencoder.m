clc, clear all;



%% load network
networkFileName = "conv_autoencoder_system1_2D_before_dropout.mat";
networkClass = "autoencoder";
networkFolderName = "..\..\results\networks\trained_";

network = load(fullfile(strcat(networkFolderName, networkClass), networkFileName));

net = network.data.net;



%% load testing data set
seriesFileName = "sys1_2Dparams_c1_0_8_1_2_c3_0_4_0_8_ICfixed_1_1_1600samples_minmax_cell";
seriesFileFolder = "..\..\resources\data\simulation\normalized";

series = load(fullfile(seriesFileFolder, seriesFileName));

rho = series.data.rho;



%% testing - regression using the obtained network
pred = predict(net, rho);

% error calculation
accuracy = zeros(numel(rho), 1);


for i = 1 : numel(rho)
    seriesLen = length(rho{i});
    accuracy(i) = mean(abs(pred{i}(1:seriesLen) - rho{i}(1:seriesLen)), 'all');
end



%% plotting
figure("Position", [10 10 900 600]);
hold on;
bar(linspace(min(series.data.meta.c3Relative), 1, numel(rho)/2), accuracy(1:numel(rho)/2)*100, 'b');
bar(linspace(1, max(series.data.meta.c3Relative), numel(rho)/2), accuracy( numel(rho)/2+1 : numel(rho) )*100, 'r');
legend("before bifurcation", "after bifurcation", "location", "northwest");
grid on;
xlabel("Relative bifurcation parameter $c_3$ [1]");
ylabel("Mean absolute error [\%]");


% set figure properties
list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end
set(findall(gcf,'-property','FontSize'),'FontSize', 18);


exportgraphics(gcf,'../../../final_docs/images/conv_autoencoder_1_training2_test2_dropout.png', 'Resolution', 300)

