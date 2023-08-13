%Data Loading
clear all;
clc;
format long;


iter = 10^3;  %1e4, 1e5
NPoints = 50;

x=[0.001,0.01,0.1,1,10,100];
Varr=[0.001,0.01,0.1,1,10,100];

%data get
[xh0001,velocity0001]=New_Measurement(iter,NPoints,0.001);
[xh001,velocity001]=New_Measurement(iter,NPoints,0.01);
[xh01,velocity01]=New_Measurement(iter,NPoints,0.1);
[xh1,velocity1]=New_Measurement(iter,NPoints,1);
[xh10,velocity10]=New_Measurement(iter,NPoints,10);
[xh100,velocity100]=New_Measurement(iter,NPoints,100);


[loc_gap_0001] = KF(iter,NPoints,xh0001,velocity0001);
[loc_gap_001] = KF(iter,NPoints,xh001,velocity001);
[loc_gap_01] = KF(iter,NPoints,xh01,velocity01);
[loc_gap_1] = KF(iter,NPoints,xh1,velocity1);
[loc_gap_10] = KF(iter,NPoints,xh10,velocity10);
[loc_gap_100] = KF(iter,NPoints,xh100,velocity100);

% 평균 위치측위 오차 성능 plot
figure(1)
semilogx(x,mean_loc_gap_6,'-o','MarkerIndices',1:6)
hold on
semilogx(x,Filt_Data,'-ro','MarkerIndices',1:6)
semilogx(x,Lpf,'-go','MarkerIndices',1:6)
legend('TOA','MovingMeanFilter','LowPassFilter')
grid on
xlabel ('Noise Variance')
ylabel('Location error (m)')