clc; clear; close all;

%% Load audio file
Audio = audioinfo('sample.wav');
[m_t, Fs] = audioread('sample.wav');
N = Audio.TotalSamples;

%% Parameters
Ts = 1 / Fs;
df = Fs / N;
t = (0:Ts:(N-1)*Ts).';
f = ((-N/2)*df:df:(N/2-1)*df).';
Carrier = struct('Amplitude', 1, 'Frequency', 1e5, 'Phase', 0);
c_t = ...
    Carrier.Amplitude * cos(2 * pi * Carrier.Frequency * t + Carrier.Phase);
M_f = fftshift(fft(m_t))*Ts;
f_m = 22050;
% M_f = lpf(M_f,1000000);
% m_t = ifft(ifftshift(M_f))/Ts;

%% DSB-LC
k_a = 0.95/max(abs(m_t));
s_t_DSB_LC = (1 + k_a .* m_t) .* c_t;
S_f_DSB_LC = fftshift(fft(s_t_DSB_LC))*Ts;

%% DSB-SC
s_t_DSB_SC = m_t .* c_t;
S_f_DSB_SC = fftshift(fft(s_t_DSB_SC))*Ts;

%% SSB
M_f_hat = -1j*M_f.*sign(f);
m_t_hat = ifft(ifftshift(M_f_hat))/Ts;
LO = cos(2*pi*Carrier.Frequency*t);
LO_hat = sin(2*pi*Carrier.Frequency*t);
s_t_SSB_USB = 0.5 * (m_t .* LO - m_t_hat .* LO_hat);
s_t_SSB_LSB = 0.5 * (m_t .* LO + m_t_hat .* LO_hat);
S_f_SSB_USB = fftshift(fft(s_t_SSB_USB))*Ts;
S_f_SSB_LSB = fftshift(fft(s_t_SSB_LSB))*Ts;

%% FM
k_f1 = 7500/max(abs(m_t));
k_f2 = 75000/max(abs(m_t));
beta1 = 7500/f_m;
beta2 = 75000/f_m;
theta_t = getIntegral(m_t,Ts);
s_t_FM1 = ...
    Carrier.Amplitude * cos(2*pi*Carrier.Frequency*t + 2*pi*k_f1*theta_t);
s_t_FM2 = ...
    Carrier.Amplitude * cos(2*pi*Carrier.Frequency*t + 2*pi*k_f2*theta_t);
S_f_FM1 = fftshift(fft(s_t_FM1))*Ts;
S_f_FM2 = fftshift(fft(s_t_FM2))*Ts;

%% Plot
figure;
subplot(3,2,1);
plot(f, abs(M_f));
title('Magnitude Spectrum of m(t)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3,2,2);
plot(f, abs(S_f_DSB_LC));
title('Magnitude Spectrum of s(t) DSB-LC');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3,2,3);
plot(f, abs(S_f_DSB_SC));
title('Magnitude Spectrum of s(t) DSB-SC');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3,2,4);
hold on
plot(f, abs(S_f_SSB_USB));
plot(f, abs(S_f_SSB_LSB));
hold off
title('Magnitude Spectrum of s(t) SSB');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('USB', 'LSB');

subplot(3,2,5);
plot(f, abs(S_f_FM1));
title('Magnitude Spectrum of s(t) FM (k_f = 7500)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3,2,6);
plot(f, abs(S_f_FM2));
title('Magnitude Spectrum of s(t) FM (k_f = 75000)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% Functions
function output = getIntegral(input,Ts)
    output = zeros(size(input));
    for i = 2:length(input)
        output(i) = output(i-1) + input(i) * Ts;
    end
end

function output = lpf(input,Bw)
    output = zeros(size(input));
    centre = ceil((length(input)+1)/2);
    for i = centre-Bw:centre+Bw
        output(i) = input(i);
    end
end
function output =bpf(input,)