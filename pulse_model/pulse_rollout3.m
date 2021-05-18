function [y] = pulse_rollout3(pa1,pa2,pa3,pa4,pa5,pa6,pa7,pa8,pa9,pa10, ... 
    pa11,pa12,pa13,pa14,pa15,pa16,pa17,pa18,pa19,pa20,M,Ts)

    N = length(pa1);
    y = zeros(N,M);
    P = tf([10],[1 4 10]);

    for i = 1:N
        
        pa = [pa1(i),pa2(i),pa3(i),pa4(i),pa5(i),pa6(i),pa7(i),pa8(i),pa9(i),pa10(i), ... 
            pa11(i),pa12(i),pa13(i),pa14(i),pa15(i),pa16(i),pa17(i),pa18(i),pa19(i),pa20(i)];
        
        indx = zeros(1,20);
        indx(1) = ceil(M/20);
        
        for j = 2:20
            indx(j) = indx(j-1) +ceil(M/20);
        end

        pulse = zeros(1,M);
        pulse(1:indx(1)) = pa(1);
        for j = 2:20
            if indx(j) <= M
                pulse(indx(j-1):indx(j)) = pa(j);
            end
        end

        y(i,:) = fo_plant_open_loop(pulse(1:M),P,Ts);
        
    end

end