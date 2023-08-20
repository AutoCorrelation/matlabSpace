function [est,error_est,error_theory] = KF(Npoints,initial_state,true_state,measurement,position_variance)
%estimate KF
A=[1 10/Npoints; 0 1];
H=[1 0;0 1];
R=[position_variance^2 0;0 0.01];
Q=zeros(2,2);  %size(initial_state,1)

est=zeros(2,Npoints);
%theory=zeros(2,1);
%step 1
state=initial_state;
error_covariance=zeros(2,2);

for t=1:Npoints
    %step 2
    predict_state=A*state;
    predict_error_covariance=A*error_covariance*A'+Q;
    %get error
    err(t,1)=abs(state(1,1)-measurement(1,t));
    %step 3
    K=predict_error_covariance*H'/(H*predict_error_covariance*H'+R);
    %step 4
    state=predict_state+K*(measurement(:,t)-H*predict_state);
    est(:,t)=state;
    %step 5
    error_covariance=(1-K*H)*predict_error_covariance;
    Q=(predict_state-state)*(predict_state-state)';
end
error_est=sum(err(:,1),'all')/Npoints;

% theory KF
A=[1 10/Npoints; 0 1];
H=[1 0;0 1];
R=[position_variance^2 0;0 0.01];
Q=zeros(2,2);  %size(initial_state,1)
err=zeros(Npoints,1);
est=zeros(2,Npoints);
%theory=zeros(2,Npoints);
%step 1
state=initial_state;
error_covariance=zeros(2,2);

for t=1:Npoints
    %step 2
    predict_state=A*state;
    predict_error_covariance=A*error_covariance*A'+Q;
    %get error
    err(t,1)=abs(state(1,1)-measurement(1,t));
    %step 3
    K=predict_error_covariance*H'/(H*predict_error_covariance*H'+R);
    %step 4
    state=predict_state+K*(measurement(:,t)-H*predict_state);
    est(:,t)=state;
    %step 5
    error_covariance=(1-K*H)*predict_error_covariance;
    Q=(measurement(:,t)-predict_state)*(measurement(:,t)-predict_state)';
end
error_theory=sum(err(:,1),'all')/Npoints;