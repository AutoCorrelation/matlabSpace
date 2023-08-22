function [K,est,theory]=KF3(iter,Npoints,variance,measurement)
final_loc_est=zeros(iter,1);
for i = 1:iter
    a=0.1*pi;

    initial_state=[0; 10*a*cos(0)];
    d = size(initial_state,1);
    A=[1 10/Npoints; 0 1];
    H=[1 0;0 1];
    R=[variance^2 0;0 0.01];
    Q=[(variance*randn(1))^2, 0; 0, (0.1*randn(1))^2];
    %ESTIMATION 예측-추정OR축정값
        
    est_state=initial_state;
    covErr=zeros(d,d);
    for j = 1:Npoits
        pre_state=A*est_state;
        pre_covErr=A*covErr*A' + Q;
        K=pre_covErr*H'/(H*pre_covErr*H'+R);
        est_state=pre_state+K*(measurement{i}(:,j)-H*pre_state);
        covErr=pre_covErr-K*H*pre_covErr;
        Q = (pre_state-est_state)*(pre_state-est_state)';

    end
    final_loc_est(i,1)=est_state(1,1);
end
final_loc_mean_est=sum(final_loc_est,'all')/iter;
est=sqrt(final_loc_mean_est^2);

%THEORY 예측-실제값
final_loc_theory=zeros(iter,1);
for i = 1:iter
    a=0.1*pi;
    true_state = [10*sin(a*t);10*a*cos(a*t)];
    initial_state=[0; 10*a*cos(0)];
    d = size(initial_state,1);
    A=[1 10/Npoints; 0 1];
    H=[1 0;0 1];
    R=[variance^2 0;0 0.01];
    Q=[(variance*randn(1))^2, 0; 0, (0.1*randn(1))^2];
    %ESTIMATION 예측-추정OR축정값
        
    est_state=initial_state;
    covErr=zeros(d,d);
    for j = 1:Npoits
        pre_state=A*est_state;
        pre_covErr=A*covErr*A' + Q;
        K=pre_covErr*H'/(H*pre_covErr*H'+R);
        est_state=pre_state+K*(measurement{i}(:,j)-H*pre_state);
        covErr=pre_covErr-K*H*pre_covErr;
        Q = (pre_state-true_state(:,t))*(pre_state-true_state(:,t))';

    end
    final_loc_theory(i,1)=est_state(1,1);
end
final_loc_mean_theory=sum(final_loc_theory,'all')/iter;
theory=sqrt(final_loc_mean_theory^2);