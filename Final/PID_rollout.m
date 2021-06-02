function [y] = PID_rollout(Kp,Ki,Kd,reference,Ts)

    N = length(Kp);
    L = length(reference);
    y = zeros(N,L);

    for i = 1:N
        
        t = linspace(0.0,Ts*L,L);
        states = zeros(L,2);
        controls = zeros(L+1);
        force = zeros(L+1);
        error = zeros(L+1);
        
        for j = 1:L
            err = reference(j) - states(j,1);
            error(j+1) = error(j) + err;
            controls(j+1) = Kp(i)*err + Kd(i)*states(j,1) + Ki(i)*error(j+1);
            states(j+1,:) = knife(states(j,:),controls(j+1),Ts);
            force(j+1) =  force(j) - 4*force(j)*Ts + states(j+1,1)*Ts;
            y(i,j) = force(j+1);
        end
        
    end

end