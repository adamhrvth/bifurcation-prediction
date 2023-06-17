clc, clear all;

addpath("./transformators");

dataset = load("raw_sections_of_measurements_0516_with_velocities.mat");

rho = cell(size(dataset.displacement, 1), 1);

for i = 1 : size(dataset.displacement, 1)
    len = floor( 1/5 * length(dataset.displacement{i}) );
    rho{i} = filter(1/len * ones(len, 1), 1,...
                                log(normalizeSeries("max +1", ...
                                 normalizeSeries("polar", dataset.displacement{i}, ...
                                                          dataset.velocity{i}...
                                ))))';
end

displacement = dataset.displacement;
velocity = dataset.velocity;
velocitylabels = dataset.velocitylabels;

save("raw_sections_of_measurements_0516_transformed_mvn_avg.mat", "displacement",...
                                                              "velocity",...
                                                              "rho",...
                                                              "velocitylabels");