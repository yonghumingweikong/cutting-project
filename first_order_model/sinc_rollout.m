function [y] = sinc_rollout(f1,f2,f3,a,reference,Ts)

    N = length(f1);
    L = length(reference);
    y = zeros(N,L);
    t = linspace(0.0,Ts*length(reference),length(reference));

    for i = 1:N
        p = sin(2*pi*f2(i)*t).*cos(2*pi*f3(i)*t);
        y(i,:) = a(i)*(1 - sinc(2*pi*f1(i)*t + p));
    end

end