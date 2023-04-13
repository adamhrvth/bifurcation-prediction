function xdot = system_dyn_2_fun(t, x, par)
    xdot = zeros(2,1);

    c1 = par(1);
    c3 = par(2);

    xdot(1)= x(2);
    xdot(2)= - x(1) - c1*x(2) - c3*x(2)^3 - x(2)^5;
end