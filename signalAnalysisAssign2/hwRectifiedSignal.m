function [hwrSignal] = hwRectifiedSignal(A,T,k,plotEnable)

L = length(k); %length of frequency range
hwrSignal = zeros(L,1); % Half-Wave Rectified Signal
phase = zeros(L,1);
% baseSignal = 2*A/T;
% fwrSignal(ceil(L/2)) = baseSignal;

for i = 1:L
    if (rem(abs(k(i)),2)==0) % k 가 짝수일 때
        hwrSignal(i) = A/((1-k(i)^2)*pi); %값 대입
    end
    if hwrSignal(i)<0
        if k(i)<0
            phase(i) = angle(hwrSignal(i));
        else
            phase(i) = -angle(hwrSignal(i));
        end
    end
end
hwrSignal(ceil(L/2)+1) = -1j*A/4;
if plotEnable == 1
   
    subplot(2,1,1);
    grid on
    stem(k,abs(hwrSignal)); % 진폭 스펙트럼
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