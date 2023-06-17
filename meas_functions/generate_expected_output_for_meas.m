clc, clear all;

targetValues = strings(833, 1);

targetValues(1:207) = "before";         %  < 1.4
targetValues(208:297) = "close";        % 1.4-1.5
targetValues(298:833) = "after";        % 1.6 <

targetValues = categorical(targetValues);

data.targetValues = targetValues;

save("expected_output_for_meas_833samples", "data");