function x_new = knife(x,u,dt)
    
    A = [0 1; 0 0];
    B = [1; 0];
    
    x_new = x.' + A*x.'*dt + B*u*dt;