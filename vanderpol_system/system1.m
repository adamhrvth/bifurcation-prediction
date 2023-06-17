%	File "system1.m" - Dynamical System
function xprime = system1 (t, x, epsilon, gamma, mu1, mu2, alpha3, beta2, beta3)

    xprime=zeros(4,1);
    
    
    % ============================= State Space ========================
    xprime(1) = x(2);

    xprime(2) = -x(1)+2*mu1*x(2)-gamma^2*epsilon*x(3)-2*mu2*gamma*epsilon*x(4)-2*mu1*x(1)^2*x(2)...
                -alpha3*x(1)^3-beta2*epsilon*x(3)^2-beta3*epsilon*x(3)^3;

    xprime(3) = x(4);
    
    xprime(4) = -x(1)+2*mu1*x(2)-gamma^2*(1+epsilon)*x(3)-2*mu2*gamma*(1+epsilon)*x(4)-2*mu1*x(1)^2*x(2)...
                -alpha3*x(1)^3-beta2*(1+epsilon)*x(3)^2-beta3*(1+epsilon)*x(3)^3;

end