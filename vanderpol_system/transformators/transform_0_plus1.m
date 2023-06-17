function x = transform_0_plus1(X)
% normalize series to be between 0 and 1 (only for entirely positive series)

    if (any(X(X < 0)))
        disp("Error: This transformation expects series containing only positive values!");
        return;
    end

    maximum = max(X);
    x = X/maximum;
end