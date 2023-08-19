function output = KF(Npoints,initial_state,true_state,measurement,position_noise)
output=zeros(size(initial_state, 1), Npoints);
A = [1 10/Npoints;0 1];
H = [1 0; 0 1];
R = [position_noise^2 0; 0 0.1^2];
Q = zeros(size(initial_state,1));
x_hat_k1=initial_state;
P_k1 = zeros(size(initial_state,1));

for t = 1:Npoints
    predict_x_hat_k = A*x_hat_k1;
    predict_P_k = A*P_k1*A' + Q;
    K = predict_P_k*H'/(H*predict_P_k*H'+R);
    x_hat_k1=predict_x_hat_k+K*(measurement(:,t)-H*predict_x_hat_k);
    output(:,t) = x_hat_k1;
    P_k1=predict_P_k-K*H*predict_P_k;
    Q=(true_state-predict_x_hat_k)*(true_state-predict_x_hat_k)';
end

