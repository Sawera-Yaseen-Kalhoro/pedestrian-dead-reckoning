function strideLength = computeStrideLength(steps,h,t)
    % Compute stride length based on empirical model.
    % steps = number of steps
    % h = height of the person
    % t = last timestamp

    sf = steps/t; % step frequency, computed from time intervals between steps

    % empirical model
    strideLength = 0.7 + 0.371*(h-1.75) + 0.227*(sf-1.79)*(h/1.75);
end
