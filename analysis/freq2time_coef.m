function tcoef = freq2time_coef(fcoef)
    
    a1 = fcoef(1);
    a2 = fcoef(2);
    b1 = fcoef(3);
    b2 = fcoef(4);
    g1 = fcoef(5);
    g2 = fcoef(6);
    Ki = fcoef(7);
    l3 = fcoef(8);
    
%     l1 = g2*l3;
%     l2 = g1*l3;
%     k1 = 1/(b2 - g2 - ((b1-g1)*g1));
%     k2 = (a1/a2) - l1;
%     b0 = a2*k1*l3/Ki;

%     l1 = g2*l3;
%     l2 = g1*l3;
%     k1 = -1/(g1*(b2 - g1) - b2 + g2/g1);
%     k2 = -(b2 - g1)/(g1*(b2 - g1) - b2 + g2/g1);
%     b0 = l3/(Ki - Ki*g2*l3 + Ki*g1^3*l3 - Ki*b2*g1^2*l3 + Ki*b2*g1*l3 + Ki*b2*g2*l3 - Ki*g1*g2*l3);

    k1 = 1/(b2-g2-(b1-g1)*g1);
    k2 = (b1-g1)*k1;
    l1 = (a1/a2)-k2;
    l2 = (1/a2) - k1 - k2*l1;
    b0 = l3*a2*k1/Ki;
    
    tcoef = [k1,k2,l1,l2,l3,b0];

end