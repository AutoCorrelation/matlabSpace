%Data Loading
clear;
clc;
format long;


iter = 1e3;  %1e4, 1e5
NPoints = 11;

x=[0.001,0.01,0.1,1,10,100];
Varr=[0.001,0.01,0.1,1,10,100];

Anchor1=[0 10]; % meter단위 (m)
Anchor2=[0 0];
Anchor3=[10 0];
Anchor4=[10 10];

Measurement_Data(iter,NPoints,Anchor1,Anchor2,Anchor3,Anchor4);

D1_Measurement_0001 = load('Measurement_from_Anchor1_at_MNV_0001.txt');
D2_Measurement_0001 = load('Measurement_from_Anchor2_at_MNV_0001.txt');
D3_Measurement_0001 = load('Measurement_from_Anchor3_at_MNV_0001.txt');
D4_Measurement_0001 = load('Measurement_from_Anchor4_at_MNV_0001.txt');


D1_Measurement_001 = load('Measurement_from_Anchor1_at_MNV_001.txt');
D2_Measurement_001 = load('Measurement_from_Anchor2_at_MNV_001.txt');
D3_Measurement_001 = load('Measurement_from_Anchor3_at_MNV_001.txt');
D4_Measurement_001 = load('Measurement_from_Anchor4_at_MNV_001.txt');

D1_Measurement_01 = load('Measurement_from_Anchor1_at_MNV_01.txt');
D2_Measurement_01 = load('Measurement_from_Anchor2_at_MNV_01.txt');
D3_Measurement_01 = load('Measurement_from_Anchor3_at_MNV_01.txt');
D4_Measurement_01 = load('Measurement_from_Anchor4_at_MNV_01.txt');

D1_Measurement_1 = load('Measurement_from_Anchor1_at_MNV_1.txt');
D2_Measurement_1 = load('Measurement_from_Anchor2_at_MNV_1.txt');
D3_Measurement_1 = load('Measurement_from_Anchor3_at_MNV_1.txt');
D4_Measurement_1 = load('Measurement_from_Anchor4_at_MNV_1.txt');

D1_Measurement_10 = load('Measurement_from_Anchor1_at_MNV_10.txt');
D2_Measurement_10 = load('Measurement_from_Anchor2_at_MNV_10.txt');
D3_Measurement_10 = load('Measurement_from_Anchor3_at_MNV_10.txt');
D4_Measurement_10 = load('Measurement_from_Anchor4_at_MNV_10.txt');

D1_Measurement_100 = load('Measurement_from_Anchor1_at_MNV_100.txt');
D2_Measurement_100 = load('Measurement_from_Anchor2_at_MNV_100.txt');
D3_Measurement_100 = load('Measurement_from_Anchor3_at_MNV_100.txt');
D4_Measurement_100 = load('Measurement_from_Anchor4_at_MNV_100.txt');


% ToA algorithm
[x_toa_0001,y_toa_0001,all_gap_loc_6_0001,F0001, LPF0001] = TOA(iter,NPoints,D1_Measurement_0001, D2_Measurement_0001, D3_Measurement_0001, D4_Measurement_0001);
[x_toa_001,y_toa_001,all_gap_loc_6_001,F001, LPF001] = TOA(iter,NPoints,D1_Measurement_001, D2_Measurement_001, D3_Measurement_001, D4_Measurement_001);
[x_toa_01,y_toa_01,all_gap_loc_6_01,F01, LPF01] = TOA(iter,NPoints,D1_Measurement_01, D2_Measurement_01, D3_Measurement_01, D4_Measurement_01);
[x_toa_1,y_toa_1,all_gap_loc_6_1,F1, LPF1] = TOA(iter,NPoints,D1_Measurement_1, D2_Measurement_1, D3_Measurement_1, D4_Measurement_1);
[x_toa_10,y_toa_10,all_gap_loc_6_10,F10, LPF10] = TOA(iter,NPoints,D1_Measurement_10, D2_Measurement_10, D3_Measurement_10, D4_Measurement_10);
[x_toa_100,y_toa_100,all_gap_loc_6_100,F100, LPF100] = TOA(iter,NPoints,D1_Measurement_100, D2_Measurement_100, D3_Measurement_100, D4_Measurement_100);

mean_loc_gap_6 = [all_gap_loc_6_0001,all_gap_loc_6_001, all_gap_loc_6_01, all_gap_loc_6_1,all_gap_loc_6_10,all_gap_loc_6_100];
Filt_Data = [F0001,F001,F01,F1,F10,F100];
Lpf = [LPF0001,LPF001,LPF01,LPF1,LPF10,LPF100];

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