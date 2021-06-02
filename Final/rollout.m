function [dx] = rollout(t,x,A,B,u,Ts)
time = linspace(0.0,Ts*length(u),length(u));
current_time = round(interp1(time,1:numel(time),t));
dx = A*x + B*u(current_time);
end