function [t, x] = getTimeSeries(systemFun, pars, tspan, x0)

    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);

    [t, x] = ode45 (@(t, xt) systemFun(t, xt, pars), tspan, x0, options);
end
