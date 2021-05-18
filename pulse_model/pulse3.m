function pulse = pulse3(coef,M)

    indx = zeros(1,20);
    indx(1) = ceil(M/20);

    for j = 2:20
        indx(j) = indx(j-1) +ceil(M/20);
    end

    pulse = zeros(1,M);
    pulse(1:indx(1)) = coef(1);
    for j = 2:20
        if indx(j) <= M
            pulse(indx(j-1):indx(j)) = coef(j);
        end
    end
    
end