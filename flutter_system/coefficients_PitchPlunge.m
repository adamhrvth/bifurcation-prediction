function par=coefficients_PitchPlunge(xa,ra,beta,nu,Omega,zetaa,zetah,xia,xih,epsilon,lambda,gamma,zeta,xi,xia5,u)


M=[1 xa 0; xa ra^2 0;0 0 1];

C=[zetah+epsilon*zeta+beta*u, -epsilon*zeta*lambda, -epsilon*zeta; ...
    -nu*u-epsilon*zeta*lambda, zetaa+epsilon*zeta*lambda^2, epsilon*zeta*lambda; ...
    -zeta, zeta*lambda, zeta];

K=[Omega^2+epsilon*gamma, beta*u^2-epsilon*gamma*lambda, -epsilon*gamma;
    -epsilon*gamma*lambda, ra^2-nu*u^2+epsilon*gamma*lambda^2, epsilon*gamma*lambda;
    -gamma, gamma*lambda, gamma];



A=[zeros(3,3), eye(3); -M\K, -M\C];
% [V,d]=eig(A,'vector');
% [autov,ind]=sort(abs(imag(d)));
% V=V(:,ind);
% par.T=[real(V(:,1)),imag(V(:,1)),real(V(:,3)),imag(V(:,3)),real(V(:,5)),imag(V(:,6))];
% W=par.T\A*par.T;
% W(abs(W)<1e-12)=0;
% par.W=W;
% par.invT=inv(par.T);
par.invM=inv(M);
par.A=A;

par.xih=xih;
par.xia=xia;
par.xia5=xia5;
par.epsilon=epsilon;
par.xi=xi;
par.lambda=lambda;
par.ra=ra;
par.xa=xa;
par.Omega=Omega;
par.beta=beta;
par.nu=nu;
par.gamma=gamma;


