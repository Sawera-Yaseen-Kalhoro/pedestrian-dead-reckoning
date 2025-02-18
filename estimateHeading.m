function heading = estimateHeading(Gyroscope, dt, Magnetometer, alpha)
    % Compute heading by combining data from gyroscope and magnetometer
    % using Complementary Filter.
    % Gyroscope = gyroscope data
    % dt = sampling time
    % Magnetometer = magnetometer data
    % alpha = Complementary Filter constant (tune as needed)

    % Gyroscope-based heading (integration of angular velocity)
    headingGyro = cumsum(Gyroscope(:,3)) * dt; % yaw is around z-axis
    headingGyro = wrapToPi(headingGyro); % wrap to (-pi,pi)
    
    % Compute heading from magnetometer
    headingMag = atan2(Magnetometer(:,1), Magnetometer(:,2));
    % remove initial bias (because magnetometer gives absolute orientation
    % wrt earth's north pole)
    headingMag = headingMag - headingMag(1);
    headingMag = wrapToPi(headingMag); % wrap to (-pi,pi)
    
    % for size mismatch bw heading gyro+mag
    n = min(length(headingGyro), length(headingMag)); % Find the minimum size
    headingGyro = headingGyro(1:n);                  % Trim headingGyro
    headingMag = headingMag(1:n);                    % Trim headingMag

    % Fusion using Complementary Filter
    heading = alpha * headingGyro + (1 - alpha) * headingMag;

    % create plot
    t = (1:length(heading)) * dt - dt;
    figure
    plot(t,rad2deg(headingGyro),...
        t,rad2deg(headingMag),...
        t,rad2deg(heading))
    xlabel('Time (s)')
    ylabel('Heading (degree)')
    legend('From Gyroscope', 'From Magnetometer','Combined')
    title('Heading')

end