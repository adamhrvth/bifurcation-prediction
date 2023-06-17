clc, clear all;



%% load simulation results
loadedFileFolder = '..\resources\data\';
loadedDataOrigin = 'simulation';
loadedFileName = 'sys1_c1_0_5_c3_3ranges_IC_0_7_2_1600samples';

load(fullfile(loadedFileFolder, loadedDataOrigin, "raw", loadedFileName));

meta = data.meta;



%% options and descriptions for file saving
savedFileName = strcat(loadedFileName, "_noisy");



%% adding noise
fn =fieldnames(data.x); 

for l = 1 : length(fn)

    for i = 1 : size(data.x.(fn{l}), 3)
        for j = 1 : size(data.x.(fn{l}), 1)
        
            for k = 1 : 5
                data.x.(fn{l})(j, 1, i) = data.x.(fn{l})(j, 1, i) + randi([-10 10])/400;
                data.x.(fn{l})(j, 2, i) = data.x.(fn{l})(j, 2, i) + randi([-10 10])/400;
            end
    
        end
    end

end



save(fullfile(loadedFileFolder, loadedDataOrigin, "raw", savedFileName), "data");


