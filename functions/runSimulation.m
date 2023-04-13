function [t, x] = runSimulation(system, c1, c3Range, x0Range, paramPoints, initPoints, tspan)
    % making available the functions representing the ODEs
    addpath(".\systems");

    % parameter points
    c3Vect = linspace(c3Range(1), c3Range(2), paramPoints);

    % initial conditions
    x0Start = x0Range(1);
    x0End = x0Range(2);

    x0= [ linspace(x0Start, x0End, initPoints/2), linspace(x0End, x0Start, initPoints/2);...
          linspace(x0Start, x0End, initPoints/2), linspace(x0Start, x0End, initPoints/2)];
    
    % time length
    tLen = length(tspan);
    
    % memory allocation for results
    t = zeros(tLen, paramPoints*initPoints);
    x = zeros(tLen, 2, paramPoints*initPoints);
    
    % calculate solutions for each parameter value and initial condition pair
    for i = 1:paramPoints
        for j = 1:initPoints
    
            ind = (i - 1) * initPoints + j;
            [t(:, ind), x(:, :, ind)] = getTimeSeries(system, [c1 c3Vect(i)], tspan, x0(:, j));
    
        end
    end

end