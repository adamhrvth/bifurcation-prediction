function x = normalizeSeries(method, varargin)
    % making available the transformator functions
    

    switch method
        case "-1 to +1"
            x = transform_min1_plus1(varargin{1});
        case "max +1"
            x = transform_0_plus1(varargin{1});
        case "polar"
            x = transform_polar(varargin{1}, varargin{2});
    end
end