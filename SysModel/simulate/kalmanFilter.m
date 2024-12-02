function [estimate_state,estimate_covariance,kalman_gain] =...
    kalmanFilter(prev_estimate_state,prev_estimate_cov,prev_velocity,Q,R,measurement,meanSysnoise)
% Kalman Filter
% Input: predict_state, predict_cov
% Output: estimate_state, estimate_covariance, kalman_gain
persistent H dt F
persistent firstRun
if isempty(firstRun)
    firstRun = 1;
    d1=10;
    d2=d1;
    H = [...
        0, -2*d2
        2*d1, -2*d2
        2*d1, 0
        2*d1, 0
        2*d1, 2*d2
        0, 2*d2];
    dt = 0.1;
    F = [1 0;0 1];
end


% predict
predict_state = F * prev_estimate_state + prev_velocity*dt + meanSysnoise;
% estimate_state = F * prev_estimate_state + prev_velocity*dt;
predict_covariance = F * prev_estimate_cov * F' + Q;
% estimate_covariance = F * prev_estimate_cov * F' + Q;

% kalman_gain = 0;
kalman_gain = (predict_covariance * H')*pinv(H * predict_covariance * H' + R);
% det(diag(diag(H * predict_covariance * H' + R)))
% kalman_gain = (predict_covariance * H')/(H * predict_covariance * H' + diag(diag(R)));
% kalman_gain = (predict_covariance * H')/diag(diag((H * predict_covariance * H' + R)));

% estimate_covariance = inv(inv(predict_covariance)+H'*pinv(R)*H);
% kalman_gain = (predict_covariance)*H'*pinv(R);

% estimate
estimate_state = predict_state + kalman_gain * (measurement - H * predict_state);
estimate_covariance = (eye(2) - kalman_gain * H) * predict_covariance;
end