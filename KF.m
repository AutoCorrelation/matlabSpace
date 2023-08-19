function[KFX] = KF(iter,NPoints,x,velocity,MNV)

%모델링한 시스템 Matrix :step 1
P_k1 = zeros(2,2); %predict error covariance (p |sub k)
x_k = zeros(1,2); %estimation postion, veloctiy
v_k = zeros(2,2);
px_k = zeros(2,2);
pP_k = zeros(2,2);


%Z_k = [x; velocity];   %(실제값)
A=[1 1;0 1];
H=[1 0;0 1];
R=[MNV^2 0;0 (0.1)^2]; %measurement noise
Q=zeros(2,2); %process noise but we try to input p_k
estimate = zeros(2,NPoints);
xhat_k1=zeros(2,1);
P_k1 = zeros(2,2);
for i=1:iter
    for j=1:NPoints
        z_k = [x(j,i); velocity(j,i)]; % real value
        %step2: prediction of the state and the covariance error
        pre_xhat_k = A*xhat_k1;
        pre_P_k = A*P_k1*transpose(A) + Q;
        %step3: computation of the Kalman gain
        K_k=pre_P_k*transpose(H)*inv(H*pre_P_k*transpose(H)+R);
        %step4: coputation of estimative(output)
        xhat_k=pre_xhat_k+K_k*(z_k-H*pre_xhat_k);
        %step5: computation of covariance error
        P_k1 = pre_P_k-K_k*H*pre_P_k;
        %data saving
        estimate(1,j)=xhat_k(1,1);
        %Measurement error,xhatk-1 update(estimation value)
        Q=P_k1;
        xhat_k1=xhat_k;
    end
end
KFX = sum(estimate,'all')/(NPoints);