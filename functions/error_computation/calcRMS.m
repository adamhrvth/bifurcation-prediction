function RMS = calcRMS(calculated, expected)
    if (length(calculated) ~= length(expected))
        disp("Error: Length of calculated and expected output do not match. Make sure they do match.")
        return;
    end

    RMS = 0;
    len = length(calculated);

    for i = 1 : len
        RMS = RMS + (calculated(i) - expected(i))^2;
    end

    RMS = sqrt(RMS/len);
end