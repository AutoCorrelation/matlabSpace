function [K_est,K_theory,est,theory,est_transition,theory_transition]=KF3(iter,Npoints,variance,measurement)
final_loc_est=zeros(iter,1);
t = linspace(0,10,Npoints);
K_est_1 = zeros(iter,Npoints);
K_est = zeros(1,Npoints);
est_transition=zeros(1,Npoints);
% exp 환경 추가
%b=0.1;
a=0.1*pi;
true_state = [10*sin(a*t);10*a*cos(a*t)];
%true_state = [exp(b*t);b*exp(b*t)];

for i = 1:iter
    a=0.1*pi;

    initial_state=[0; 10*a*cos(0)];
    %exp 환경 추가
    %initial_state = [exp(0);b*exp(0)];
    
    d = size(initial_state,1);
    A=[1 10/Npoints; 0 1];
    H=[1 0;0 1];
    R=[variance^2 0;0 0.01];
    Q=[(variance*randn(1))^2, 0; 0, (0.1*randn(1))^2];
    % Q=[(variance*randn(1)), 0; 0, (0.1*randn(1))];
    %Q=zeros(2,2);
    %ESTIMATION 예측-추정OR정값
        
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
        K_est_1(i,j) = norm(covErr,'fro');  % K(P_cov 값 저장
        if i==iter
           est_transition(1,j)=est_state(1,1) ;
        end
    end
    final_loc_est(i,1)=est_state(1,1);

end
for j=1:Npoints
    K_est(1,j)=sum(K_est_1(:,j),"all")/iter ; %저장 평균
end
final_loc_mean_est=sum(final_loc_est,'all')/iter;
est=sqrt((final_loc_mean_est-true_state(1,Npoints))^2);

K_theory_1 = zeros(iter,Npoints);
K_theory = zeros(1,Npoints);
theory_transition=zeros(1,Npoints);
%THEORY 예측-실제값
final_loc_theory=zeros(iter,1);

for i = 1:iter
    
    initial_state=[0; 10*a*cos(0)];
    %initial_state = [exp(0);b*exp(0)];
    d = size(initial_state,1);
    A=[1 10/Npoints; 0 1];
    H=[1 0;0 1];
    R=[variance^2 0;0 0.01];
    Q2=[(variance*randn(1))^2, 0; 0, (0.1*randn(1))^2];
    %Q2=zeros(2,2);
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
        K_theory_1(i,j) = norm(covErr,'fro');  % K 값 저장 각 iter의 스텝
        % 별로 평균내기
        if i==iter
           theory_transition(1,j)=est_state(1,1) ;
        end
    end
    final_loc_theory(i,1)=est_state(1,1);
    
end
for j=1:Npoints
    K_theory(1,j)=sum(K_theory_1(:,j),"all")/Npoints;
end


final_loc_mean_theory=sum(final_loc_theory,'all')/iter;
theory=sqrt((final_loc_mean_theory-true_state(1,Npoints))^2);


%data get
