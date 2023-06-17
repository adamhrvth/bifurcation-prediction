% File "solve.m" - Matlab Runge Kutta 4-5
% close all;
clear all;
t0=0;	            % initial time
tic
tfinal=200;	        % final time
x0 = [1 2 0 0];
% x0=[0.25 0 0 0;];	    % column vector of initial conditions
tspan=[t0 tfinal]';	% tspan can contain other specific points of integration.

option=odeset('RelTol', 1e-10, 'AbsTol', 1e-10);

% ========================== Parameter Definitions ===================
epsilon=0.05;
gamma=0.97;

% mu_1crit = 0.1005, start of coexistence of sols.: mu_1 = 0.0619
mu11=0.04;
mu12 = 0.11;
mu2=0.12;

alpha3=0.3;
beta2=0;
beta3=0;


[t1,x1]=ode45(@(t,x) system1(t, x, epsilon, gamma, mu11, mu2, alpha3, beta2, beta3), tspan, x0, option);		    %for MATLAB-6
[t2,x2]=ode45(@(t,x) system1(t, x, epsilon, gamma, mu12, mu2, alpha3, beta2, beta3), tspan, x0, option);


% plotting the results
%=======================================================
toc

figure("Position", [10 10 800 600]);

subplot (2, 1, 1)
plot (t1,x1(:,1), "LineWidth", 1.25); hold on; plot (t1,x1(:,3), "LineWidth", 1.25);
legend("$x_1$", "$x_2$"); grid minor;
title("$\mu_1 = 0.04$");
ylabel ('Pseudo-displacement [1]');

subplot (2, 1, 2)
plot (t2,x2(:,1), "LineWidth", 1.25); hold on; plot (t2,x2(:,3), "LineWidth", 1.25);
legend("$x_1$", "$x_2$"); grid minor;
title("$\mu_1 = 0.11$");
xlabel ('Pseudo-time [1]'); ylabel ('Pseudo-displacement [1]');


list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end
set(findall(gcf,'-property','FontSize'),'FontSize', 18);

exportgraphics(gcf,'../../final_docs/images/vanderpol_series_bifurcation_illustration.png', 'Resolution', 300)
