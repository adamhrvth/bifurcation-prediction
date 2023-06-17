% clear

% parameters
xa=0.2;
ra=0.5;
beta=0.2;
nu=0.08;
Omega=0.5;
zetaa=0.01;
zetah=0.01;
epsilon=0.05;
lambda=1;
zeta=0.11;
gamma=0.462;
%xi=0.218;
xi=0.4;
xia=-1;
xia5=7;
xih=0;

u1=0.7;
u2=0.85;

par1=coefficients_PitchPlunge(xa,ra,beta,nu,Omega,zetaa,zetah,xia,xih,epsilon,lambda,gamma,zeta,xi,xia5,u1);
par2=coefficients_PitchPlunge(xa,ra,beta,nu,Omega,zetaa,zetah,xia,xih,epsilon,lambda,gamma,zeta,xi,xia5,u2);


% initial condition
x0=[2, 2, -2, 0, 0, 0];

% final time
tfinal=300;

% simulation
option=odeset('RelTol', 1e-8, 'AbsTol', 1e-8); % tolerances for the simulations

[t1,x1]=ode45 (@(t,xt) system_PaP(t,xt,par1), [0 tfinal], x0, option);
[t2,x2]=ode45 (@(t,xt) system_PaP(t,xt,par2), [0 tfinal], x0, option);



figure("Position", [10 10 1200 600]);

subplot(2, 2, 1);
plot(t1, x1(:,1), "LineWidth", 1.25); hold on;
plot(t1, x1(:,2), "LineWidth", 1.25);
legend("$y$", "$\alpha$");
title("$\tilde{U} = 0.7$");
ylabel("Pseudo-displacement [1]");
grid minor;

subplot(2, 2, 3)
plot(t1, x1(:,3), "LineWidth", 1.25);
legend("$\tilde{x}$");
ylabel("Pseudo-displacement [1]");
xlabel("Pseudo-time [1]");
grid minor;

subplot(2, 2, 2);
plot(t2, x2(:,1), "LineWidth", 1.25); hold on;
plot(t2, x2(:,2), "LineWidth", 1.25);
legend("$y$", "$\alpha$");
title("$\tilde{U} = 0.85$");
grid minor;

subplot(2, 2, 4)
plot(t2, x2(:,3), "LineWidth", 1.25);
legend("$\tilde{x}$");
xlabel("Pseudo-time [1]");
grid minor;



list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end
set(findall(gcf,'-property','FontSize'),'FontSize', 18);



exportgraphics(gcf,'../../final_docs/images/flutter_series_bifurcation_illustration.png', 'Resolution', 300)


