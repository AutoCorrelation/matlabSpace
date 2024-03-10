function [output] = LKF(iter,Npoints, x_toa, y_toa)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[Q,P_0,simulated_W] = simulation(iter,Npoints, x_toa, y_toa);
dT = 1;
A = [1 dT; 0 1];
H = [1 0; 0 1];
% Q = [0.3^2 0;0 0.3^2];
R = zeros(6,1);
% P_0 = [0.1; 0.1];
estimate_Errcov = P_0;


for num1 = 1:iter
    state_0 = [x_toa(num1,1); y_toa(num1,1)];
    estimate_State = state_0;
    for num2 = 1:Npoints
        Z = H*[x_toa(num1,num2); y_toa(num1,num2)];

        predict_State = A*estimate_State + simulated_W;
        predict_Errcov = A*estimate_Errcov*A' + Q;
        k_Gain = predict_Errcov*H'/(H*predict_Errcov*H');
        estimate_State = predict_State + k_Gain*(Z-H*predict_State);
        estimate_Errcov = predict_Errcov - k_Gain*H*predict_Errcov;
    end
end