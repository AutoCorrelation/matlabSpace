function [K_est,K_theory,est,theory,est_transition,theory_transition]=KF3(iter,Npoints,variance,measurement)
final_loc_est=zeros(iter,1);
t = linspace(0,10,Npoints);
K_est_1 = zeros(1,Npoints);
K_est_2 = zeros(1,iter);
est_transition=zeros(1,Npoints);

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
    for j = 1:Npoints
        pre_state=A*est_state;
        pre_covErr=A*covErr*A' + Q;
        K=pre_covErr*H'/(H*pre_covErr*H'+R);
        est_state=pre_state+K*(measurement{i}(:,j)-H*pre_state);
        covErr=pre_covErr-K*H*pre_covErr;
        Q = (pre_state-est_state)*(pre_state-est_state)';
        %Q = (pre_state-measurement{i}(:,j))*(pre_state-measurement{i}(:,j))';
        K_est_1(1,j) = norm(covErr,'fro');  % K(P_cov 값 저장
        if i==iter
           est_transition(1,j)=est_state(1,1) ;
        end
    end
    final_loc_est(i,1)=est_state(1,1);
    K_est_2(1,i)=sum(K_est_1,"all")/Npoints; %p cov 평균
end
final_loc_mean_est=sum(final_loc_est,'all')/iter;
est=sqrt(final_loc_mean_est^2);
K_est=sum(K_est_2,"all")/iter;

K_theory_1 = zeros(1,Npoints);
K_theory_2 = zeros(1,iter);
theory_transition=zeros(1,Npoints);
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
    Q2=[(variance*randn(1))^2, 0; 0, (0.1*randn(1))^2];
    %THEORY 예측-실제값
        
    est_state=initial_state;
    covErr=zeros(d,d);
    for j = 1:Npoints
        pre_state=A*est_state;
        pre_covErr=A*covErr*A' + Q2;
        K=pre_covErr*H'/(H*pre_covErr*H'+R);
        est_state=pre_state+K*(measurement{i}(:,j)-H*pre_state);
        covErr=pre_covErr-K*H*pre_covErr;
        Q2 = (pre_state-true_state(:,j))*(pre_state-true_state(:,j))';
        K_theory_1(1,j) = norm(covErr,'fro');  % K 값 저장
        if i==iter
           theory_transition(1,j)=est_state(1,1) ;
        end
    end
    final_loc_theory(i,1)=est_state(1,1);
    K_theory_2(1,i)=sum(K_theory_1,"all")/Npoints;
end
final_loc_mean_theory=sum(final_loc_theory,'all')/iter;
theory=sqrt(final_loc_mean_theory^2);
K_theory=sum(K_est_1,"all")/iter;

%data get
