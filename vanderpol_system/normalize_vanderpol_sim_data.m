clc, clear all;

addpath("./transformators");

load("vanderpol_sim_data_tspan_fixed_varyingICs.mat");

x1Normed = cell(150*10, 1);
x2Normed = cell(150*10, 1);

for j = 1 : 10
for i = 1 : 150
%     x1Normed{(j-1)*150 + i} = log(normalizeSeries("max +1" ,normalizeSeries("polar", data.x{i}(:, 1), data.x{i}(:, 3))))';
%     x2Normed{(j-1)*150 + i} = log(normalizeSeries("max +1" ,normalizeSeries("polar", data.x{i}(:, 2), data.x{i}(:, 4))))';
    x1Normed{(j-1)*150 + i} = normalizeSeries("abs -1 to +1", data.x{i}(:, 1))';
    x2Normed{(j-1)*150 + i} = normalizeSeries("abs -1 to +1", data.x{i}(:, 2))';
end
end

data.rho = x1Normed;
save("vanderpol_x1_varyingICs_absamp", "data");
data.rho = x2Normed;
save("vanderpol_x2_varyingICs_absamp", "data");


