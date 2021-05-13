function F = minfun(x,reference,actual,Ts)

F = sum( (abs(ADRC_FO_rollout(x(1),x(2),x(3),x(4),reference,Ts) - actual)).' ) / M;

end