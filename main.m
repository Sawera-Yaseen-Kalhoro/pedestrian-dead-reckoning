% main.m

clear all; close all; clc;

% Load IMU data from .mat files
data = load('data/vania_phone_log.mat'); % Replace with actual .mat file name

% extract data from timestamp objects
accel_data = [data.Acceleration.X,data.Acceleration.Y,data.Acceleration.Z];
accel_time = seconds(data.Acceleration.Timestamp - data.Acceleration.Timestamp(1));
mag_data = [data.MagneticField.X,data.MagneticField.Y,data.MagneticField.Z];
mag_time = seconds(data.MagneticField.Timestamp - data.MagneticField.Timestamp(1));
gyro_data = [data.AngularVelocity.X,data.AngularVelocity.Y,data.AngularVelocity.Z];
gyro_time = seconds(data.AngularVelocity.Timestamp - data.AngularVelocity.Timestamp(1));
angle_data = [data.Orientation.X,data.Orientation.Y,data.Orientation.Z];
angle_time = seconds(data.Orientation.Timestamp - data.Orientation.Timestamp(1));

sample_rate = 100;

dt = 1/sample_rate; % Sample time in seconds

% Compute number of steps from accelerometer data
steps = detectSteps(accel_data,accel_time, 11.5); % Detect steps with a threshold (adjust as needed)

disp('Number of steps:');
disp(steps);

% Calculate stride length
h = 1.64; % height of the person
t_end = max([accel_time(end),mag_time(end),gyro_time(end)]);
strideLength = computeStrideLength(steps,h,t_end);

disp('Stride Length:');
disp(strideLength);

% Estimate heading using gyroscope and magnetometer data
heading = estimateHeading(gyro_data, dt,mag_data, 0.98);

% Create trajectory based on stride length and heading
trajectory = updatePosition(steps, heading, strideLength);

% Display estimated trajectory
figure
plot(trajectory(:,1),trajectory(:,2),'o-')
title("Trajectory")
xlabel("x")
ylabel("y")
axis equal