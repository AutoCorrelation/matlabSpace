function [estimate_state,estimate_covariance,kalman_gain] =...
    kalmanFilter(prev_estimate_state,prev_estimate_cov,prev_velocity,Q,R,measurement,meanSysnoise)
% Kalman Filter
% Input: predict_state, predict_cov
% Output: estimate_state, estimate_covariance, kalman_gain
dt = 0.1;
F = [1 0;0 1];
H = 1;

% predict
predict_state = F * prev_estimate_state + prev_velocity*dt + meanSysnoise;
% estimate_state = F * prev_estimate_state + prev_velocity*dt;
predict_covariance = F * prev_estimate_cov * F' + Q;
% estimate_covariance = F * prev_estimate_cov * F' + Q;

% kalman_gain = 0;
kalman_gain = predict_covariance * H' / (H * predict_covariance * H' + R);

% estimate
estimate_state = predict_state + kalman_gain * (measurement - H * predict_state);
estimate_covariance = (eye(2) - kalman_gain * H) * predict_covariance;
end