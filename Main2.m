%Data Loading
clear all;
clc;
format long;


iter = 10^3;  %1e4, 1e5
NPoints = 50;

x_dim=[0.001,0.01,0.1,1,10,100];
Varr=[0.001,0.01,0.1,1,10,100];

%real value get
[x0001,velocity0001]=New_Measurement(iter,NPoints,0.001);
[x001,velocity001]=New_Measurement(iter,NPoints,0.01);
[x01,velocity01]=New_Measurement(iter,NPoints,0.1);
[x1,velocity1]=New_Measurement(iter,NPoints,1);
[x10,velocity10]=New_Measurement(iter,NPoints,10);
[x100,velocity100]=New_Measurement(iter,NPoints,100);

%kalman filter algorithm
[KFX0001] = KF(iter,NPoints,x0001,velocity0001,0001);
[KFX001] = KF(iter,NPoints,x001,velocity001,001);
[KFX01] = KF(iter,NPoints,x01,velocity01,01);
[KFX1] = KF(iter,NPoints,x1,velocity1,1);
[KFX10] = KF(iter,NPoints,x10,velocity10,10);
[KFX100] = KF(iter,NPoints,x100,velocity100,100);

Filt_Data_x = [KFX0001,KFX001,KFX01,KFX1,KFX10,KFX100];
%Filt_Data_v = [KFV0001,KFV001,KFV01,KFV1,KFV10,KFV100];
% 평균 위치측위 오차 성능 plot
figure(1)
%semilogx(x,mean_loc_gap_6,'-o','MarkerIndices',1:6)
hold on
semilogx(x_dim,Filt_Data_x,'-ro','MarkerIndices',1:6)
%semilogx(x,Filt_Data_v,'-go','MarkerIndices',1:6)
legend('KALMAN FILTER')
grid on
xlabel ('Noise Variance')
ylabel('Location error (m)')