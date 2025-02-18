# Repo for RSPA Seminar 1 - Pedestrian Dead Reckoning (PDR)

Team members:
* Fatima Yousif Rustamani
* Sawera Yaseen
* Vania Katherine Mulia

## Contents
* `main.m`: The main script containing the full pipeline of PDR.
* `detectSteps.m`: Function to detect and count steps based on accelerometer data.
* `computeStrideLength.m`: Function to estimate stride length based on the number of detected steps and person's height.
* `estimateHeading.m`: Function to estimate heading over time by fusing gyroscope and magnetometer data.
* `updatePosition.m`: Function to construct trajectory given the stride length and heading over time.

## Running the Algorithm

Run the `main.m` script in MATLAB.