function steps = detectSteps(accel_data,t,peak_threshold)
    % Estimate number of steps from accelerometer data.
    % accel_data = nx3 array, where n is the number of data
    % t = nx1 array of timestamps corresponding to accel_data
    % peak_threshold = minimum threshold for a peak (adjust based on data)

    % magnitude of acceleration
    acc_x = accel_data(:,1);
    acc_y = accel_data(:,2);
    acc_z = accel_data(:,3);
    acc_total = sqrt(acc_x.^2 + acc_y.^2 + acc_z.^2);

    % step detection parameter
    min_peak_distance = 0.3; % Minimum time between steps (in seconds)
    
    % Detect peaks in the vertical (z-axis) acceleration
    [pks, locs] = findpeaks(acc_total, t, 'MinPeakHeight', peak_threshold, 'MinPeakDistance', min_peak_distance);
    
    % Step counting (number of peaks detected)
    steps = length(pks);

    % Plotting Results
    figure;
    plot(t, acc_total);
    hold on;
    plot(locs, pks, 'ro'); % Mark detected steps with red circles
    title(['Step Detection (Total Steps: ', num2str(steps), ')']);
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    legend('Total Acceleration', 'Detected Steps');
end