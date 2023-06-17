function par  = getPars(u)
    
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
    
    
    par=coefficients_PitchPlunge(xa,ra,beta,nu,Omega,zetaa,zetah,xia,xih,epsilon,lambda,gamma,zeta,xi,xia5,u);

end