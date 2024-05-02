function [fwrSignal] = fwRectifiedSignal(A,T,k,plotEnable)

L = length(k); %length of frequency range
fwrSignal = zeros(L,1); % Full-Wave Rectified Signal
phase = zeros(L,1);
% baseSignal = 2*A/T;
% fwrSignal(ceil(L/2)) = baseSignal;

for i = 1:L
    if (rem(abs(k(i)),2)==0) % k 가 짝수일 때
        fwrSignal(i) = 2*A/((1-k(i)*k(i))*pi); %값 대입
    end
    if fwrSignal(i)<0
        if k(i)<0
            phase(i) = angle(fwrSignal(i));
        else
            phase(i) = -angle(fwrSignal(i));
        end
    end
end
fwrSignal(ceil(L/2)) = 2*A/pi;
if plotEnable == 1
    grid on
    subplot(2,1,1);
    stem(k,abs(fwrSignal)); % 진폭 스펙트럼
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