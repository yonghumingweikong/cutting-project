function plot_pulse(coef,profile,Ts)

    P = tf([10],[1 4 10]);

    pl = ceil([coef(1),coef(2),coef(3),coef(4),coef(5),coef(6),coef(7),coef(8),coef(9),coef(10)]);
    pa = [coef(11),coef(12),coef(13),coef(14),coef(15),coef(16),coef(17),coef(18),coef(19),coef(20)];

    indx = zeros(1,10);
    indx(1) = pl(1);

    for j = 2:10
        indx(j) = indx(j-1) + pl(j);
    end

    pulse = zeros(1,180);
    pulse(1:indx(1)) = pa(1);
    for j = 2:10
        if indx(j) <= 180
            pulse(indx(j-1):indx(j)) = pa(j);
        end
    end

    y = fo_plant_open_loop(pulse(1:180),P,Ts);
    
    plot(y); hold on; plot(profile,'--'); plot(pulse);
    
end