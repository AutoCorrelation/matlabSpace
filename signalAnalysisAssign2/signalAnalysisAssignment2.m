clear all;
close all;
clc
format long;

% let We know Ampitude = 2, T = 2, Fourier Coefficient,
% Get Fourier Series Spectrum & Signal.

% Define Variable
Amplitude = 2;
T_period = 2;
N = 50; %set fequency max amplitude
k = -N:N; %set frequency Range

% 1 전파 정류파 신호 (Full-Wave Rectified Signal)
figure(1)
fwR = fwRectifiedSignal(Amplitude, T_period,k,1); %Show spectrum.
figure(2)
signalSynthesis(Amplitude,T_period,k,fwR); %Show Signal

% 2 방형파 신호 
figure(3)
rectW = rectWaveSignal(Amplitude, T_period,k,1); 
figure(4)
signalSynthesis(Amplitude,T_period,k,rectW);


% figure(5)
% hwR = hwRectifiedSignal(Amplitude, T_period,k,1); 
% figure(6)
% signalSynthesis(Amplitude,T_period,k,hwR);

