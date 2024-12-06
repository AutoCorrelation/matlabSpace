function [x_hat, P] = func_KF(previous_state, previous_covariance, vel, bias, Q, R, Z)
% Kalman Filter
% Prediction
persistent first_Run H A;
if isempty(first_Run)
    first_Run = 1;
    d1=10;
    d2=d1;
    H = [...
        0, -2*d2
        2*d1, -2*d2
        2*d1, 0
        2*d1, 0
        2*d1, 2*d2
        0, 2*d2];
    A = eye(2);
end

x_hat_minus = A*previous_state + vel + bias;
P_minus = A*previous_covariance*A' + Q;

% Regularize R matrix
epsilon = 1e-6;
R = R + epsilon * eye(size(R));

% Update
K = P_minus*H'/(H*P_minus*H' + R);
x_hat = x_hat_minus + K*(Z - H*x_hat_minus);
P = (eye(2) - K*H)*P_minus;
end