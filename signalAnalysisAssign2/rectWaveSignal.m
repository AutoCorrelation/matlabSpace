function [rectSignal] = rectWaveSignal(A,T,k,plotEnable)

L = length(k); %length of frequency range
rectSignal = zeros(L,1); % Full-Wave Rectified Signal
phase = zeros(L,1);
% baseSignal = 2*A/T;
% fwrSignal(ceil(L/2)) = baseSignal;

for i = 1:L
    if (rem(abs(k(i)),2)==1) % k 가 홀수 일때
        rectSignal(i) = -1j*2*A/(k(i)*pi); %값 대입
    end
    
    % if rectSignal(i)<0
    %     phase(i) = -angle(rectSignal(i));
    % end
end
rectSignal(ceil(L/2)) = 0; % k=0일 때 푸리에 급수

phase = angle(rectSignal);
if plotEnable == 1
    grid on
    subplot(2,1,1);
    stem(k,abs(rectSignal)); % 진폭 스펙트럼
    title("Amplitude Spectrum");
    xlabel("W");
    ylabel("|X_k|")

    subplot(2,1,2);
    stem(k,phase); % 위상 스펙트럼
    title("Phase Spectrum");
    xlabel("W");
    ylabel("∠X_k")

end
end