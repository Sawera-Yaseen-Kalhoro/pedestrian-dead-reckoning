function position = updatePosition(steps, heading, strideLength)
    % Create trajectory based on stride length and heading.
    % steps = number of steps taken
    % heading = heading evolution (over time)
    % strideLength = length of each step

    % downsample the heading data
    n = int64(length(heading)/steps); % downsampling factor
    heading_ds = downsample(heading,n);

    position = [0, 0]; % Initialize at origin

    for i = 1:steps
        deltaX = strideLength * cos(heading_ds(i)); % Calculate change in X
        deltaY = strideLength * sin(heading_ds(i)); % Calculate change in Y
        position(i+1,:) = position(i,:) + [deltaX, deltaY]; % Update position
    end
end
