clear;
close all;

%data creating
position_variance=[0.001,0.01,0.1,1,10,100];
velocity_variance=0.1;

iter=1e4;
a=0.1*pi;

% When Npoints 10
Npoints1 = 50;
[measurement0001,measurement001,measurement01,measurement1,measurement10,measurement100] = MD(iter,Npoints1);
%kalman filter Algorithm 1
[K_est0001,K_theory0001,est0001,theory0001,est_transition0001,theory_transition0001]=KF3(iter,Npoints1,0.001,measurement0001);
[K_est001,K_theory001,est001,theory001,est_transition001,theory_transition001]=KF3(iter,Npoints1,0.01,measurement001);
[K_est01,K_theory01,est01,theory01,est_transition01,theory_transition01]=KF3(iter,Npoints1,0.1,measurement01);
[K_est1,K_theory1,est1,theory1,est_transition1,theory_transition1]=KF3(iter,Npoints1,1,measurement1);
[K_est10,K_theory10,est10,theory10,est_transition10,theory_transition10]=KF3(iter,Npoints1,10,measurement10);
[K_est100,K_theory100,est100,theory100,est_transition100,theory_transition100]=KF3(iter,Npoints1,100,measurement100);
est_all_gap=[est0001 est001 est01 est1 est10 est100];
P_cov=[K_est0001 K_est001 K_est01 K_est1 K_est10 K_est10];
theory_all_gap=[theory0001 theory001 theory01 theory1 theory10 theory100];
%When Npoints 100
Npoints2 = 200;
[s_measurement0001,s_measurement001,s_measurement01,s_measurement1,s_measurement10,s_measurement100] = MD(iter,Npoints2);
%kalman filter Algorithm 2
[s_K_est0001,s_K_theory0001,s_est0001,s_theory0001,s_est_transition0001,s_theory_transition0001]=KF3(iter,Npoints2,0.001,s_measurement0001);
[s_K_est001,s_K_theory001,s_est001,s_theory001,s_est_transition001,s_theory_transition001]=KF3(iter,Npoints2,0.01,s_measurement001);
[s_K_est01,s_K_theory01,s_est01,s_theory01,s_est_transition01,s_theory_transition01]=KF3(iter,Npoints2,0.1,s_measurement01);
[s_K_est1,s_K_theory1,s_est1,s_theory1,s_est_transition1,s_theory_transition1]=KF3(iter,Npoints2,1,s_measurement1);
[s_K_est10,s_K_theory10,s_est10,s_theory10,s_est_transition10,s_theory_transition10]=KF3(iter,Npoints2,10,s_measurement10);
[s_K_est100,s_K_theory100,s_est100,s_theory100,s_est_transition100,s_theory_transition100]=KF3(iter,Npoints2,100,s_measurement100);
s_est_all_gap=[s_est0001 s_est001 s_est01 s_est1 s_est10 s_est100];
s_theory_all_gap=[s_theory0001 s_theory001 s_theory01 s_theory1 s_theory10 s_theory100];
s_P_cov=[s_K_est0001 s_K_est001 s_K_est01 s_K_est1 s_K_est10 s_K_est10];

%plot 1
figure;
semilogx(position_variance,est_all_gap,'-b');
hold on
semilogx(position_variance,theory_all_gap,"--b");
semilogx(position_variance,s_est_all_gap,'-r');
semilogx(position_variance,s_theory_all_gap,"--r");
legend('est50','theory50','est200','theory200');
xlabel('Position variance');
ylabel('Err');
title('Error each variance at step 50 and 200');
hold off

%plot 2
t = linspace(0,10,Npoints2);
figure;
plot(1:Npoints2,s_K_est1,'LineWidth',2);
hold on
plot(1:Npoints2,s_K_theory1,'LineWidth',2);
legend('est','theory');
xlabel('step');
ylabel('estimation cov value');
hold off
%plot 3

%true_state = [10*sin(a*t);10*a*cos(a*t)];
%exp 환경 추가
b=0.1;
true_state = [exp(b*t);b*exp(b*t)];

figure;
plot(t, true_state(1, :), 'g');
hold on
plot(t, s_measurement1{iter}(1, :), 'b.');
plot(t, s_est_transition1(1,:), 'r', 'LineWidth', 2);
xlabel('step');
ylabel('Location');
legend('True Position', 'Measurements', 'Estimated Position');
title('Location Estimation using Kalman Filter');