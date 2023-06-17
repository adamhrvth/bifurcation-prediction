clc, clear all;

addpath("./transformators");

load("flutter_sim_data_tspan_fixed.mat");

yNormed = cell(2400, 1);
alphaNormed = cell(2400, 1);
xtNormed = cell(2400, 1);

for i = 1 : 2400
    len = floor(size(data.x{i}(:, 1), 1)/10);

    yNormed{i} = filter(1/len * ones(len, 1), 1, ...
          log(normalizeSeries("max +1" ,normalizeSeries("polar", data.x{i}(:, 1), data.x{i}(:, 4)))))';

    alphaNormed{i} = filter(1/len * ones(len, 1), 1, ...
        log(normalizeSeries("max +1" ,normalizeSeries("polar", data.x{i}(:, 2), data.x{i}(:, 5)))))';

    xtNormed{i} = filter(1/len * ones(len, 1), 1, ...
        log(normalizeSeries("max +1" ,normalizeSeries("polar", data.x{i}(:, 3), data.x{i}(:, 6)))))';
end

data.rho = yNormed;
save("y_polar_log_mvn_avg", "data");
data.rho = alphaNormed;
save("alpha_polar_log_mvn_avg", "data");

data.rho = xtNormed;
save("xt_polar_log_mvn_avg", "data");


