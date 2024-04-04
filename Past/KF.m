function [K,est1,est2] = KF(Npoints,initial_state,true_state,measurement,position_variance)

%estimate KF
A=[1 10/Npoints; 0 1];
H=[1 0;0 1];
R=[position_variance^2 0;0 0.01];
Q=zeros(2,2);  %size(initial_state,1)
est1=zeros(2,Npoints);
%step 1
state=initial_state;
error_covariance=zeros(2,2);
for t=1:Npoints
    %step 2
    predict_state=A*state;
    predict_error_covariance=A*error_covariance*A'+Q;
    %step 3
    K=predict_error_covariance*H'/(H*predict_error_covariance*H'+R);
    %step 4
    state=predict_state+K*(measurement(:,t)-H*predict_state);
    est1(:,t)=state;
    %step 5
    error_covariance=(1-K*H)*predict_error_covariance;
    Q=(predict_state-state)*(predict_state-state)';
    %get error
end


% theory KF
Q=zeros(2,2);  %size(initial_state,1)
est2=zeros(2,Npoints);
%theory=zeros(2,Npoints);
%step 1
state=initial_state;
error_covariance=zeros(2,2);
for t=1:Npoints
    %step 2
    predict_state=A*state;
    predict_error_covariance=A*error_covariance*A'+Q;
    %step 3
    K=predict_error_covariance*H'/(H*predict_error_covariance*H'+R);
    %step 4
    state=predict_state+K*(measurement(:,t)-H*predict_state);
    est2(:,t)=state;
    %step 5
    error_covariance=(1-K*H)*predict_error_covariance;
    Q=(measurement(:,t)-predict_state)*(measurement(:,t)-predict_state)';
    %get error
end

