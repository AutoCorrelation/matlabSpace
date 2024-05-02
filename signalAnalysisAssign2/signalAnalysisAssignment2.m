clear all;
close all;
clc
format long;

% let Ampitude = 2, T = 2, We know Fourier Series.
% Get Fourier Coefficient Spectrum.

% Define Variable
Amplitude = 2;
T_period = 2;
N = 50; %set fequency max range
k = -N:N; %get frequency Range
% 1-1 전파 정류파 신호 식 (Full-Wave Rectified Signal)
% figure(1)
% fwR = fwRectifiedSignal(Amplitude, T_period,k,1);
% figure(2)
% signalSynthesis(Amplitude,T_period,k,fwR);
figure(3)
rectW = rectWaveSignal(Amplitude, T_period,k,1); 
figure(4)
signalSynthesis(Amplitude,T_period,k,rectW);
% figure(5)
% hwR = hwRectifiedSignal(Amplitude, T_period,k,1); 
% figure(6)
% signalSynthesis(Amplitude,T_period,k,hwR);
% % 1-2
