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
c_t = Carrier.Amplitude*cos(2*pi*Carrier.Frequency*t+Carrier.Phase);
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
k_f = 75000/max(abs(m_t));
theta_t = getIntegral(m_t,Ts);
s_t_FM2 = Carrier.Amplitude*cos(2*pi*Carrier.Frequency*t+2*pi*k_f*theta_t);
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

m_t_DSB_SC_A = demoldulate_DSB_SC(r_t_DSB_SC_A,LO_DSB_SC_A);
m_t_DSB_SC_B = demoldulate_DSB_SC(r_t_DSB_SC_B,LO_DSB_SC_B);
m_t_DSB_SC_C = demoldulate_DSB_SC(r_t_DSB_SC_C,LO_DSB_SC_C);
m_t_DSB_SC_D = demoldulate_DSB_SC(r_t_DSB_SC_D,LO_DSB_SC_D);

M_f_DSB_SC_A = fftshift(fft(m_t_DSB_SC_A))*Ts;
M_f_DSB_SC_B = fftshift(fft(m_t_DSB_SC_B))*Ts;
M_f_DSB_SC_C = fftshift(fft(m_t_DSB_SC_C))*Ts;
M_f_DSB_SC_D = fftshift(fft(m_t_DSB_SC_D))*Ts;

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

m_t_FM_A = demoldulate_FM(r_t_FM_A,LO_FM_A,Ts,k_f);
m_t_FM_B = demoldulate_FM(r_t_FM_B,LO_FM_B,Ts,k_f);
m_t_FM_C = demoldulate_FM(r_t_FM_C,LO_FM_C,Ts,k_f);
m_t_FM_D = demoldulate_FM(r_t_FM_D,LO_FM_D,Ts,k_f);

M_f_FM_A = fftshift(fft(m_t_FM_A))*Ts;
M_f_FM_B = fftshift(fft(m_t_FM_B))*Ts;
M_f_FM_C = fftshift(fft(m_t_FM_C))*Ts;
M_f_FM_D = fftshift(fft(m_t_FM_D))*Ts;

%% Plot
figure;
subplot(3,2,1);
plot(f,abs(M_f));
title('Magnitude Spectrum of m(t)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3,2,2);
% plot(f,abs(M_f_FM_A));
plot(f,abs(M_f_DSB_SC_A));
title('Magnitude Spectrum of m(t) (FM Demodulation A)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3,2,3);
% plot(f,abs(M_f_FM_B));
plot(f,abs(M_f_DSB_SC_B));
title('Magnitude Spectrum of m(t) (FM Demodulation B)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3,2,4);
% plot(f,abs(M_f_FM_C));
plot(f,abs(M_f_DSB_SC_C));
title('Magnitude Spectrum of m(t) M_f_DSB_SC_A');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3,2,5);
% plot(f,abs(M_f_FM_D));
plot(f,abs(M_f_DSB_SC_D));
title('Magnitude Spectrum of m(t) M_f_DSB_SC_B');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% Output file
FM_m_t_DSB_SC_D = m_t_DSB_SC_C./max(abs(m_t_DSB_SC_C(:)));
audiowrite('output.wav',FM_m_t_DSB_SC_D, Fs);

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
    centre = ceil((length(input)+1)/2);
    for i = centre-Bw:centre+Bw
        output(i) = input(i);
    end
end

function y = my_hilbert(x)
    N = length(x);
    
    % Step 1: FFT 계산
    X = fft(x);
    
    % Step 2: 필터 벡터 h 생성
    h = zeros(N, 1);
    h(1) = 1;  % DC 성분
    
    if mod(N,2) == 0  % N이 짝수인 경우
        h(2:N/2) = 2;
        h(N/2+1) = 1;  % Nyquist 주파수
    else  % N이 홀수인 경우
        h(2:(N+1)/2) = 2;
    end
    
    % Step 3: FFT 결과와 필터의 요소별 곱
    Y = X .* h;
    
    % Step 4: IFFT 계산
    y = ifft(Y);
end

function output = demoldulate_DSB_SC(input,LO)
    temp1 = input .* LO;
    temp2 = fftshift(fft(temp1));
    temp3 = lowpass(temp2,1500000);
    output = ifft(ifftshift(temp3));
end

function output = demoldulate_FM(input,LO,Ts,k_f)
temp1 = my_hilbert(input)./LO;

temp2 = unwrap(angle(temp1));
temp3 = getDerivative(temp2,Ts);
output = temp3/(2*pi*k_f);
end

