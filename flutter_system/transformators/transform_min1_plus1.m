function x = transform_min1_plus1(X)
% normalize series to be between -1 and 1
    minimum = min(X);
    maximum = max(X);
    x = (X - minimum) / (maximum - minimum) * 2 - 1;
end