clear;
close all;
clc
format long;

% let We know Ampitude = 2, T = 2, Fourier Coefficient,

% Define Variable
Amplitude = 2;
T_period = 2;
N = 50; %set number of max harmonics
k = -N:N; %set frequency Range

% 1 전파 정류파 신호 (Full-Wave Rectified Signal)
figure(1)
fwR = fwRectifiedSignal(Amplitude, T_period, k,1); %Show spectrum.
figure(2)
harmonicsSynthesis(Amplitude,T_period, k,fwR); %Show Signal

% 2 방형파 신호 
figure(3)
squareW = squareWaveSignal(Amplitude, T_period,k,1); 
figure(4)
harmonicsSynthesis(Amplitude,T_period,k,squareW);

%추가 진행 삼각파
figure(5)
triW = triWaveSignal(Amplitude, T_period, k,1);
figure(6)
harmonicsSynthesis(Amplitude,T_period,k,triW);

%추가 진행 반파 정류파 half-wave rectified signal
figure(7)
hwR = hwRectifiedSignal(Amplitude, T_period,k,1); 
figure(8)
harmonicsSynthesis(Amplitude,T_period,k,hwR);