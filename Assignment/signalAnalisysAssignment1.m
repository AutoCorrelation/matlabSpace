clear;
close all;
clc;

%% 1) Initial Variables
t = -2:0.01:2;
A = [1, 2, 3];
f = [1, 2, 3];
phase = [0, pi / 2, -pi / 2];

plotCos(A, f, phase, t);

%% 2) param = t, scale value, shiftValue,Plot On=1/off=0
t = -4:0.01:4;
scale1 = 1/2;
shift1=0;
plotRect(t, scale1,shift1,1);

scale2 = 1;
shift2=0;
plotTri(t,scale2,shift2,1);
plotSinc(t,scale2);
%% 3) Fusion
fusionRecTri(t,scale1,scale2);