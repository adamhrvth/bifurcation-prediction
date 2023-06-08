clc, clear all;



%% load network
networkFileName = "conv_autoencoder_system1_2D_after.mat";
networkClass = "autoencoder";
networkFolderName = "..\..\results\networks\trained_";

network = load(fullfile(strcat(networkFolderName, networkClass), networkFileName));

net = network.data.net;



%% load testing data set
seriesFileName = "sys1_2Dparams_c1_0_2_c3_0_2_ICfixed_1_1_1600samples_minmax_cell";
% seriesFileName = "sys2_2Dparams_c1_0_1_0_5_c3_0_1_5_ICfixed_1_1_1600samples_minmax_cell";
seriesFileFolder = "..\..\resources\data\simulation\normalized";

series = load(fullfile(seriesFileFolder, seriesFileName));

rho = series.data.rho;



%% testing - regression using the obtained network
pred = predict(net, rho);

% error calculation
accuracy = zeros(series.data.meta.paramPoints, series.data.meta.paramPoints);


for i = 1 : series.data.meta.paramPoints
    for j = 1 : series.data.meta.paramPoints

        ind = (i-1)*series.data.meta.paramPoints + j;
        seriesLen = length(rho{ind});
        accuracy(j, i) = mean(abs(pred{ind}(1:seriesLen) - rho{ind}(1:seriesLen)), 'all');

    end
end



%% plotting
% crit = 1.34 * -10/9 * sqrt(2);
crit = 40/9;

figure("Position", [10 10 900 600]);
hold on;

[X, Y] = meshgrid(series.data.meta.c1Range, series.data.meta.c3/crit);

surf(X, Y, accuracy*100, "linestyle", "none");
thresholdX = linspace(min(series.data.meta.c1Range), max(series.data.meta.c1Range), series.data.meta.paramPoints);
%thresholdY = 1.34 * -10/9 .* sqrt(2*thresholdX) ./ crit;
thresholdY = 40 / 9 * thresholdX / crit;
plot3(thresholdX, ...
      thresholdY, ones(1, series.data.meta.paramPoints)*100, ...
      'Color', 'k', 'LineWidth', 1.5);

hcb = colorbar;
hcb.Title.String = "MAE [\%]";
hcb.Title.Interpreter = "latex";

xlabel("$c_1$ [1]");
ylabel("Relative bifurcation parameter $c_3$ [1]");
xlim([min(series.data.meta.c1Range) max(series.data.meta.c1Range)]);
ylim([min(series.data.meta.c3/crit) max(series.data.meta.c3/crit)]);



% set figure properties
list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end
set(findall(gcf,'-property','FontSize'),'FontSize', 18);


exportgraphics(gcf,'../../../final_docs/images/conv_autoencoder_1_2Dparams_after_test1.png', 'Resolution', 300)

