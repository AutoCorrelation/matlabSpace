%Writer : Chung Mj 2024-05-30
clear
close all;
clc

timeRange=0.04;
ts=[1/75; 1/100; 1/150; 1/400; 1/2000]; %벡터로 저장 후 반복문을 통해 접근
tsstring={'1/75'; '1/100'; '1/150'; '1/400'; '1/2000'}; %title에 사용함
f0=100; %정현파 주파수
%%Figure 1
figure(1)
for num1=1:length(ts)
    t=0:ts(num1):timeRange;     %시간 벡터
    Xt=cos(2*pi*f0*t);          %정현파 벡터
    subplot(3,2,num1)
    stem(t,Xt);                 %출력
    grid on
    title(sprintf("ts=%s",tsstring{num1}));    
    xlabel('t')
end
%%Figure 2
figure(2)
N = 1024;   %샘플링 할 데이터 개수
fs=1./ts;   %1/샘플링 주기=샘플링 주파수
for num1=1:length(ts)   %샘플링 주기 벡터 길이만큼 반복
    t=0:ts(num1):(N-1)*ts(num1);    %N개의 균일 샘플 시간 벡터
    x=cos(2*pi*f0*t);               %100Hz cos정현파 샘플링 벡터
    df=fs(num1)/N;                  %주파수 분해능=FFT된 결과에서 인접한 주파수 성분 사이 간격
    X=fft(x);                       %Fast Fourier Transform Algorithm.
    X_shift=fftshift(X);            %실수신호는 진폭 스펙트럼이 켤레복소수인 양방향 스펙트럼
                                    %0Hz을 중심으로 바꾸기 위해 fftshift 이용
                                    %ex)N=5 기준
                                    % 0 1 2 3 4 -> 3 4 0 1 2 이런식으로 바뀐다.
                                    % 참고로 3 4 와 -2 1은 구분이 안되므로 이런식으로 바꿔도 된다
    f=(-N/2)*df:df:(N/2-1)*df;      %-fs/2~fs/2 범위의 주파수 벡터로 볼 수 있다.
    subplot(3,2,num1)
    % plot(f,abs(X_shift)/max(abs(X_shift))); %기존 코드
    plot(f,abs(X_shift)/N); % 수정
    grid on
    title(sprintf("ts=%s",tsstring{num1}));    
    xlabel('t')
end



