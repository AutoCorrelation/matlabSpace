clc; clear; close all;

%% Load audio file
Audio = audioinfo('sample.wav');
[m_t, Fs] = audioread('sample.wav');
Ts = 1 / Fs;
N = Audio.TotalSamples;
df = Fs / N;
t = (0:Ts:(N-1)*Ts).';
f = ((-N/2)*df:df:(N/2-1)*df).';

%% Parameters
Carrier = struct('Amplitude', 1, 'Frequency', 1e5, 'Phase', 0);
c_t = Carrier.Amplitude * cos(2 * pi * Carrier.Frequency * t + Carrier.Phase);
M_f = fftshift(fft(m_t))*Ts;
demodulationA = struct('SNR',0,'fc',1e5,'theta',0);
demodulationB = struct('SNR',30,'fc',1e5,'theta',0);
demodulationC = struct('SNR',30,'fc',1e5-1,'theta',0);
demodulationD = struct('SNR',30,'fc',1e5,'theta',89*pi/180);

%% DSB-SC
s_t_DSB_SC = m_t .* c_t;
S_f_DSB_SC = fftshift(fft(s_t_DSB_SC))*Ts;
power_DSB_SC = mean(s_t_DSB_SC.*s_t_DSB_SC);

%% FM
k_f2 = 75000/max(abs(m_t));
theta_t = getIntegral(m_t,Ts);
s_t_FM2 = Carrier.Amplitude * cos(2*pi*Carrier.Frequency*t + 2*pi*k_f2*theta_t);
S_f_FM2 = fftshift(fft(s_t_FM2))*Ts;
power_FM = mean(s_t_FM2.*s_t_FM2);

%% DSB-SC Demodulate
DSB_SC_Noise_A = sqrt(power_DSB_SC/10^(demodulationA.SNR/10))*randn(N,1);
DSB_SC_Noise_B = sqrt(power_DSB_SC/10^(demodulationB.SNR/10))*randn(N,1);
DSB_SC_Noise_C = sqrt(power_DSB_SC/10^(demodulationC.SNR/10))*randn(N,1);
DSB_SC_Noise_D = sqrt(power_DSB_SC/10^(demodulationD.SNR/10))*randn(N,1);
r_t_DSB_SC_A = s_t_DSB_SC + DSB_SC_Noise_A;
r_t_DSB_SC_B = s_t_DSB_SC + DSB_SC_Noise_B;
r_t_DSB_SC_C = s_t_DSB_SC + DSB_SC_Noise_C;
r_t_DSB_SC_D = s_t_DSB_SC + DSB_SC_Noise_D;
LO_DSB_SC_A = 2*cos(2*pi*demodulationA.fc*t + demodulationA.theta);
LO_DSB_SC_B = 2*cos(2*pi*demodulationB.fc*t + demodulationB.theta);
LO_DSB_SC_C = 2*cos(2*pi*demodulationC.fc*t + demodulationC.theta);
LO_DSB_SC_D = 2*cos(2*pi*demodulationD.fc*t + demodulationD.theta);
v_t_DSB_SC_A = r_t_DSB_SC_A .* LO_DSB_SC_A;
v_t_DSB_SC_B = r_t_DSB_SC_B .* LO_DSB_SC_B;
v_t_DSB_SC_C = r_t_DSB_SC_C .* LO_DSB_SC_C;
v_t_DSB_SC_D = r_t_DSB_SC_D .* LO_DSB_SC_D;
V_f_DSB_SC_A = fftshift(fft(v_t_DSB_SC_A))*Ts;
V_f_DSB_SC_B = fftshift(fft(v_t_DSB_SC_B))*Ts;
V_f_DSB_SC_C = fftshift(fft(v_t_DSB_SC_C))*Ts;
V_f_DSB_SC_D = fftshift(fft(v_t_DSB_SC_D))*Ts;
M_f_hat_DSB_SC_A = lowpass(V_f_DSB_SC_A,177000);
M_f_hat_DSB_SC_B = lowpass(V_f_DSB_SC_B,177000);
M_f_hat_DSB_SC_C = lowpass(V_f_DSB_SC_C,177000);
M_f_hat_DSB_SC_D = lowpass(V_f_DSB_SC_D,177000);
m_t_hat_DSB_SC_A = ifft(ifftshift(M_f_DSB_SC_hat_A))/Ts;
m_t_hat_DSB_SC_B = ifft(ifftshift(M_f_DSB_SC_hat_B))/Ts;
m_t_hat_DSB_SC_C = ifft(ifftshift(M_f_DSB_SC_hat_C))/Ts;
m_t_hat_DSB_SC_D = ifft(ifftshift(M_f_DSB_SC_hat_D))/Ts;

%% FM Demodulate
FM_Noise_A = sqrt(power_FM/10^(demodulationA.SNR/10))*randn(N,1);
FM_Noise_B = sqrt(power_FM/10^(demodulationB.SNR/10))*randn(N,1);
FM_Noise_C = sqrt(power_FM/10^(demodulationC.SNR/10))*randn(N,1);
FM_Noise_D = sqrt(power_FM/10^(demodulationD.SNR/10))*randn(N,1);
r_t_FM_A = s_t_FM2 + FM_Noise_A;
r_t_FM_B = s_t_FM2 + FM_Noise_B;
r_t_FM_C = s_t_FM2 + FM_Noise_C;
r_t_FM_D = s_t_FM2 + FM_Noise_D;
LO_FM_A = exp(1j*2*pi*demodulationA.fc*t+demodulationA.theta);
LO_FM_B = exp(1j*2*pi*demodulationB.fc*t+demodulationB.theta);
LO_FM_C = exp(1j*2*pi*demodulationC.fc*t+demodulationC.theta);
LO_FM_D = exp(1j*2*pi*demodulationD.fc*t+demodulationD.theta);
R_f_FM_A = fftshift(fft(r_t_FM_A))*Ts;
R_f_FM_B = fftshift(fft(r_t_FM_B))*Ts;
R_f_FM_C = fftshift(fft(r_t_FM_C))*Ts;
R_f_FM_D = fftshift(fft(r_t_FM_D))*Ts;
Hilbert_f_FM_A = -1j*R_f_FM_A.*sign(f);
Hilbert_f_FM_B = -1j*R_f_FM_B.*sign(f);
Hilbert_f_FM_C = -1j*R_f_FM_C.*sign(f);
Hilbert_f_FM_D = -1j*R_f_FM_D.*sign(f);
m_t_hat_FM_A = ifft(ifftshift(Hilbert_f_FM_A))/Ts;
m_t_hat_FM_B = ifft(ifftshift(Hilbert_f_FM_B))/Ts;
m_t_hat_FM_C = ifft(ifftshift(Hilbert_f_FM_C))/Ts;
m_t_hat_FM_D = ifft(ifftshift(Hilbert_f_FM_D))/Ts;
phase_FM_A = unwrap(angle(m_t_hat_FM_A));
phase_FM_B = unwrap(angle(m_t_hat_FM_B));
phase_FM_C = unwrap(angle(m_t_hat_FM_C));
phase_FM_D = unwrap(angle(m_t_hat_FM_D));

% FM 복조하기






%% Functions
function output = getIntegral(input,Ts)
    output = zeros(size(input));
    for i = 2:length(input)
        output(i) = output(i-1) + input(i) * Ts;
    end
end

function output = getDerivative(input,Ts)
    output = zeros(size(input));
    for i = 2:length(input)
        output(i) = (input(i) - input(i-1)) / Ts;
    end
end

function output = lowpass(input,Bw)
    output = zeros(size(input));
    for i = -Bw:Bw
        output(i)=input(i);
    end
end
