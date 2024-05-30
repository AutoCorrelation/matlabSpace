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
shift1 = 0;
plotRect(t, scale1, shift1, 1);

scale2 = 1;
shift2 = 0;
plotTri(t, scale2, shift2, 1);
plotSinc(t, scale2, 1);

%% 3) Fusion
fusionRecTri(t, scale1, scale2);

temp1 = fft(plotSinc(t, 1, 0));
temp2 = fftshift(temp1);
Fs = 1/0.01; % 샘플링 주파수 (샘플링 간격의 역수)
L = length(t); % 신호 길이
f = Fs * (-L / 2:L / 2 - 1) / L; % 주파수 벡터
plot(f, abs(temp2));
