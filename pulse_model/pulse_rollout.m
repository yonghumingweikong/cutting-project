function [y] = pulse_rollout(px2,px3,px4,px5,pl1,pl2,pl3,pl4,pl5,pa1,pa2,pa3,pa4,pa5,M,Ts)

    N = length(px2);
    y = zeros(N,M);
    P = tf([10],[1 4 10]);
    
    px1 = 1;
    px2 = ceil(px2);
    px3 = ceil(px3);
    px4 = ceil(px4);
    px5 = ceil(px5);
    
    pl1 = ceil(pl1);
    pl2 = ceil(pl2);
    pl3 = ceil(pl3);
    pl4 = ceil(pl4);
    pl5 = ceil(pl5);

    for i = 1:N
        
        pulse = zeros(1,M);
        pulse(px1:px1+pl1(i)) = pa1(i);
        pulse(px2(i):px2(i)+pl2(i)) = pa2(i);
        pulse(px3(i):px3(i)+pl3(i)) = pa3(i);
        pulse(px4(i):px4(i)+pl4(i)) = pa4(i);
        pulse(px5(i):px5(i)+pl5(i)) = pa5(i);
        
        y(i,:) = fo_plant_open_loop(pulse(1:M),P,Ts);
        
    end

end