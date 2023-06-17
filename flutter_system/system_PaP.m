% system for pitch and plunge wing with NLDVA
function xprime = system_PaP(~,x,par)

b=[par.epsilon*par.xi*(x(1)-x(3)-par.lambda*x(2))^3; ...
    par.xia*x(2)^3+par.xia5*x(2)^5+par.epsilon*par.lambda*par.xi*(x(3)+par.lambda*x(2)-x(1))^3; ...
    par.xi*(x(3)+par.lambda*x(2)-x(1))^3];
% ============================= State Space ========================
xprime=par.A*x-[zeros(3,1);par.invM*b];
% ===================================================================

    
end


% U=0.5*(Omega^2+epsilon*gamma).*x(:,1).^2-epsilon*gamma*lambda*x(:,1).*x(:,2)-epsilon*gamma*x(:,1).*x(:,3)+ ...
%     0.5*(ra^2+epsilon*gamma*lambda^2)*x(:,2).^2+epsilon*gamma*lambda*x(:,2).*x(:,3)+0.5*epsilon*gamma*x(:,3).^2+ ...
%     0.25*xih*x(:,1).^4+0.25*epsilon*xi*(x(:,1)-x(:,3)-lambda*x(:,2)).^4+0.25*xia*x(:,2).^4;