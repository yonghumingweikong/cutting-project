function dxdt = myode(t,x,A,B,ut,u)
    
    u = interp1(ut,u,t);
    dxdt = A*x + B*u;