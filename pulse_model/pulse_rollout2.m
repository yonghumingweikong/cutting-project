function [y] = pulse_rollout2(pl1,pl2,pl3,pl4,pl5,pl6,pl7,pl8,pl9,pl10, ...
pa1,pa2,pa3,pa4,pa5,pa6,pa7,pa8,pa9,pa10,M,Ts)

    N = length(pl2);
    y = zeros(N,M);
    P = tf([10],[1 4 10]);
    
    pl1 = ceil(pl1);
    pl2 = ceil(pl2);
    pl3 = ceil(pl3);
    pl4 = ceil(pl4);
    pl5 = ceil(pl5);
    pl6 = ceil(pl6);
    pl7 = ceil(pl7);
    pl8 = ceil(pl8);
    pl9 = ceil(pl9);
    pl10 = ceil(pl10);

    for i = 1:N
        
        pl = [pl1(i),pl2(i),pl3(i),pl4(i),pl5(i),pl6(i),pl7(i),pl8(i),pl9(i),pl10(i)];
        pa = [pa1(i),pa2(i),pa3(i),pa4(i),pa5(i),pa6(i),pa7(i),pa8(i),pa9(i),pa10(i)];
        
        indx = zeros(1,10);
        indx(1) = pl(1);
        
        for j = 2:10
            indx(j) = indx(j-1) + pl(j);
        end

        pulse = zeros(1,M);
        pulse(1:indx(1)) = pa(1);
        for j = 2:10
            if indx(j) <= M
                pulse(indx(j-1):indx(j)) = pa(j);
            end
        end

        y(i,:) = fo_plant_open_loop(pulse(1:M),P,Ts);
        
    end

end