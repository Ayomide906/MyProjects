%% Stage 4: GPS + IMU Simulation with Kalman Filter (MATLAB Online Compatible)
% This version uses only core MATLAB functions for online compatibility

% Simulation parameters
dt = 0.1;              % Time step (s)
tEnd = 60;             % Simulation time (s)
time = 0:dt:tEnd;
N = numel(time);

% True trajectory (circle path)
radius = 20;
omega = 2*pi / 60;     % radians per second
truePos = [radius*cos(omega*time)', radius*sin(omega*time)'];
trueVel = [-radius*omega*sin(omega*time)', radius*omega*cos(omega*time)'];

%% Simulate IMU measurements (core MATLAB implementation)
% Accelerometer: a = dv/dt + gravity compensation
accel_true = diff(trueVel)/dt;
accel_true = [accel_true; accel_true(end,:)];  % Maintain size
accel_true(:,3) = -9.81;  % Add gravity component (z-axis)

% Add noise to accelerometer
accel_noise = 0.00002;
accel_meas = accel_true + accel_noise*randn(N,3);

% Gyroscope: angular velocity (yaw rate only)
gyro_true = [zeros(N,2), repmat(omega, N, 1)];  % [0, 0, omega]

% Add noise to gyroscope
gyro_noise = 0.01;
gyro_meas = gyro_true + gyro_noise*randn(N,3);

%% Simulate GPS measurements
gpsNoiseStd = 0.5; % meters
gpsPos = truePos + gpsNoiseStd*randn(N,2);

%% Kalman filter setup
A = [1 0 dt 0;   % State transition matrix
     0 1 0 dt;
     0 0 1 0;
     0 0 0 1];
 
H = [1 0 0 0;    % Measurement matrix
     0 1 0 0];
 
Q = diag([0.01, 0.01, 0.1, 0.1]);  % Process noise covariance
R = gpsNoiseStd^2 * eye(2);         % Measurement noise covariance

% Initialize state and covariance
x = [gpsPos(1,1); gpsPos(1,2); 0; 0];  % [x, y, vx, vy]
P = eye(4);

estPos = zeros(N,2);
vel_est = zeros(N,2);

%% Kalman filter with IMU prediction
for k = 1:N
    % --- Prediction Step (IMU-driven) ---
    % Use accelerometer to predict velocity
    if k > 1
        % Rotate acceleration from body to world frame (simplified 2D)
        yaw_angle = atan2(x(4), x(3));  % Estimated heading from velocity
        
        % Rotation matrix (body to world)
        R = [cos(yaw_angle), -sin(yaw_angle);
             sin(yaw_angle),  cos(yaw_angle)];
        
        % Convert body acceleration to world frame
        acc_world = R * accel_meas(k,1:2)';
        
        % Update state prediction with acceleration
        x(3:4) = x(3:4) + acc_world * dt;
    end
    
    % Apply state transition
    x = A * x;
    P = A * P * A' + Q;
    
    % --- Update Step (GPS measurement) ---
    z = gpsPos(k,:)';
    y = z - H * x;          % Measurement residual
    S = H * P * H' + R;     % Residual covariance
    K = P * H' / S;         % Kalman gain
    
    % State update
    x = x + K * y;
    P = (eye(4) - K * H) * P;
    
    % Store results
    estPos(k,:) = x(1:2)';
    vel_est(k,:) = x(3:4)';
end

%% Plot results
figure;

% Position plot
subplot(2,1,1);
plot(truePos(:,1), truePos(:,2), 'k-', 'LineWidth', 2); hold on;
plot(gpsPos(:,1), gpsPos(:,2), 'rx', 'MarkerSize', 4);
plot(estPos(:,1), estPos(:,2), 'b-', 'LineWidth', 1.5);
legend('True Path', 'GPS Measurements', 'Kalman Estimate');
xlabel('X (m)');
ylabel('Y (m)');
title('Position Estimation');
grid on;
axis equal;

% Velocity plot
subplot(2,1,2);
plot(time, trueVel(:,1), 'k-', 'LineWidth', 2); hold on;
plot(time, trueVel(:,2), 'k--', 'LineWidth', 2);
plot(time, vel_est(:,1), 'b-', 'LineWidth', 1.5);
plot(time, vel_est(:,2), 'r-', 'LineWidth', 1.5);
legend('True V_x', 'True V_y', 'Estimated V_x', 'Estimated V_y');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity Estimation');
grid on;