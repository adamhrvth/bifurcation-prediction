clc, clear all;

% making transformator functions available
addpath('./transformators');



%% load simulation results
loadedFileFolder = '..\resources\data\';
loadedDataOrigin = 'simulation';
loadedFileName = 'sys1_c1_0_5_c3_3ranges_IC_0_7_2_1600samples';

load(fullfile(loadedFileFolder, loadedDataOrigin, "raw", loadedFileName));

xBefore = data.x.xStable;
xClose = data.x.xClose;
xAfter = data.x.xBif;

x = zeros(size(xBefore, 3) + size(xClose, 3) + size(xAfter, 3), size(xBefore, 1));
xdot = zeros(size(xBefore, 3) + size(xClose, 3) + size(xAfter, 3), size(xBefore, 1));

for i = 1 : size(xBefore, 3) + size(xClose, 3) + size(xAfter, 3)

    if (i <= size(xBefore, 3))
        x(i, :) = xBefore(:, 1, i)';
        xdot(i, :) = xBefore(:, 2, i)';
    elseif (size(xBefore, 3) < i && i <= (size(xBefore, 3) + size(xClose, 3)))
        x(i, :) = xClose(:, 1, i - size(xBefore, 3))';
        xdot(i, :) = xClose(:, 2, i - size(xBefore, 3))';
    else
        x(i, :) = xAfter(:, 1, i - size(xBefore, 3) - size(xClose, 3))';
        xdot(i, :) = xAfter(:, 2, i - size(xBefore, 3) - size(xClose, 3))';
    end

end

meta = data.meta;



%% options and descriptions for file saving
savedFileName = strcat(loadedFileName, "_polar");
savedFileFolder = "..\resources\data\simulation\normalized";



%% normalization

% calculate rho for each series
rho = cell(size(x, 1), 1);

for i = 1 : size(x, 1)
    rho{i} = normalizeSeries("max +1", normalizeSeries("polar", x(i, :), xdot(i, :)));
end


%% extend metadata
meta.normalization = "polar transformation and then setting the maximum to be 1";



%% save normalized simulation results
clear data;

data.rho = rho;
data.meta = meta;

save(fullfile(savedFileFolder, savedFileName), "data");


