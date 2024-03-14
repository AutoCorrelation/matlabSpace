%Data Loading
clear all;
clc;
format long;

iter = 1e4;  %1e4, 1e5
NPoints = 10;

Var=[0.001,0.01,0.1,1,10,100];

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
[all_gap_pos_0001_1,x_toa_0001,y_toa_0001] = TOA(iter,NPoints, ...
    D1_Measurement_0001,D2_Measurement_0001,D3_Measurement_0001,D4_Measurement_0001);
[all_gap_pos_001_1,x_toa_001,y_toa_001] = TOA(iter,NPoints, ...
    D1_Measurement_001,D2_Measurement_001,D3_Measurement_001,D4_Measurement_001);
[all_gap_pos_01_1,x_toa_01,y_toa_01] = TOA(iter,NPoints, ...
    D1_Measurement_01,D2_Measurement_01,D3_Measurement_01,D4_Measurement_01);
[all_gap_pos_1_1,x_toa_1,y_toa_1] = TOA(iter,NPoints, ...
    D1_Measurement_1, D2_Measurement_1,D3_Measurement_1,D4_Measurement_1);
[all_gap_pos_10_1,x_toa_10,y_toa_10] = TOA(iter,NPoints, ...
    D1_Measurement_10, D2_Measurement_10,D3_Measurement_10,D4_Measurement_10);
[all_gap_pos_100_1,x_toa_100,y_toa_100] = TOA(iter,NPoints, ...
    D1_Measurement_100, D2_Measurement_100,D3_Measurement_100,D4_Measurement_100);

%LPF algorithm
all_gap_pos_0001_2 = TOA_LPF(iter,NPoints, ...
    D1_Measurement_0001,D2_Measurement_0001,D3_Measurement_0001,D4_Measurement_0001);
all_gap_pos_001_2 = TOA_LPF(iter,NPoints, ...
    D1_Measurement_001,D2_Measurement_001,D3_Measurement_001,D4_Measurement_001);
all_gap_pos_01_2 = TOA_LPF(iter,NPoints, ...
    D1_Measurement_01,D2_Measurement_01,D3_Measurement_01,D4_Measurement_01);
all_gap_pos_1_2 = TOA_LPF(iter,NPoints, ...
    D1_Measurement_1, D2_Measurement_1,D3_Measurement_1,D4_Measurement_1);
all_gap_pos_10_2 = TOA_LPF(iter,NPoints, ...
    D1_Measurement_10, D2_Measurement_10,D3_Measurement_10,D4_Measurement_10);
all_gap_pos_100_2 = TOA_LPF(iter,NPoints, ...
    D1_Measurement_100, D2_Measurement_100,D3_Measurement_100,D4_Measurement_100);




%error average per variances(0.001~100)
mean_loc_gap_1 = [all_gap_pos_0001_1 all_gap_pos_001_1 all_gap_pos_01_1 all_gap_pos_1_1 all_gap_pos_10_1 all_gap_pos_100_1];
mean_loc_gap_2 = [all_gap_pos_0001_2 all_gap_pos_001_2 all_gap_pos_01_2 all_gap_pos_1_2 all_gap_pos_10_2 all_gap_pos_100_2];
% 평균 위치측위 오차 성능 plot
figure(1);
semilogx(Var,mean_loc_gap_1,'-o','MarkerIndices',1:6)
grid on
hold on
semilogx(Var,mean_loc_gap_2,'-o','MarkerIndices',1:6)
title('Evaluation based on Location Accuracy')
legend('TOA','LPF')
% legend('TOA','LPF','LKF')
xlabel ('Noise Variance')
ylabel('Location error (m)')