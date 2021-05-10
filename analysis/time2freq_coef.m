function fcoef = time2freq_coef(tcoef)
    
    Num = height(tcoef);
    fcoef = zeros(Num,8);
    
    for n = 1:Num
        
        Kp = tcoef(n,1);
        Kd = tcoef(n,2);
        l1 = tcoef(n,3);
        l2 = tcoef(n,4);
        l3 = tcoef(n,5);
        b0 = tcoef(n,6);
        
        Ki = (1.0/b0)*(Kp*l3)/(Kp+Kd*l1+l2);
        a1 = (Kd+l1)/(Kp+Kd*l1+l2);
        a2 = 1.0/(Kp+Kd*l1+l2);
        b1 = (l2/l3 + Kd/Kp);
        b2 = l1/l3 + (Kd/Kp)*(l2/l3) + 1/Kp;
        g1 = l2/l3;
        g2 = l1/l3;
        
        fcoef(n,:) = [a1,a2,b1,b2,g1,g2,Ki,tcoef(n,5)];
    end
end

