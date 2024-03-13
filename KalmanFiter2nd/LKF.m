function [output] = LKF(iter,Npoints, x_toa, y_toa,var)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[Q,P_0,simulated_W] = simulation(iter,Npoints, x_toa, y_toa);
dT = 1;
A = [1 0; 0 1];
H = [1 0; 0 1];
R = [var^2 0; 0 var^2];
% Q = [0.3^2 0;0 0.3^2];
% P_0 = [0.1; 0.1];
K_output = zeros(iter,Npoints);

% output = zeros(1,Npoints); %Kalman gain
estimate_Errcov = P_0;

est_pos = zeros(2,Npoints); %pos
iter_result = zeros(2,iter);

for num1 = 1:iter
    % state_0 = [x_toa(num1,1); y_toa(num1,1)];
    % estimate_State = state_0;
    for num2 = 1:Npoints
        if num2<3
            est_pos(:,num2) = [x_toa(num1,num2); y_toa(num1,num2)];
            estimate_State = est_pos(:,num2);
            continue;
        end
        x_vel = x_toa(num1,num2) - x_toa(num1,num2-1);
        y_vel = y_toa(num1,num2) - y_toa(num1,num2-1);
        Z = H*[x_toa(num1,num2); y_toa(num1,num2)];
        
        predict_State = A*estimate_State + [x_vel; y_vel] + simulated_W; %이거 수정중입니다.
        predict_Errcov = A*estimate_Errcov*A' + Q;
        k_Gain = predict_Errcov*H'/(H*predict_Errcov*H'+R);
        estimate_State = predict_State + k_Gain*(Z-H*predict_State);
        estimate_Errcov = predict_Errcov - k_Gain*H*predict_Errcov;

        K_output(num1,num2) = norm(k_Gain);
        % est_pos(1,num2) = estimate_State(1,1);
        % est_pos(2,num2) = estimate_State(2,1);
    end
    iter_result(1,num1) = abs(10-estimate_State(1,1));
    iter_result(2,num1) = abs(10-estimate_State(2,1));
end

for i = 1:Npoints %kalmang ain
    output(1,i) = sum(K_output(:,i),'all')/Npoints;
end
% output = sum(iter_result,'all')/(2*iter); % pos
end