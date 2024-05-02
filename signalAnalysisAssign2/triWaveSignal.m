function [triSignal] = triWaveSignal(A,T,k,plotEnable)

L = length(k); %length of frequency range
triSignal = zeros(L,1); % Full-Wave Rectified Signal
phase = zeros(L,1);
% baseSignal = 2*A/T;
% fwrSignal(ceil(L/2)) = baseSignal;

for i = 1:L
    if (rem(abs(k(i)),2)==1) % k 가 짝수일 때
        triSignal(i) = -2*A/(k(i)^2*pi^2); %값 대입
    end
    if triSignal(i)<0
        if k(i)<0
            phase(i) = +pi;
        else
            phase(i) = -pi;
        end
    end
end
triSignal(ceil(L/2)) = A/2;
if plotEnable == 1
    grid on
    subplot(2,1,1);
    stem(k,triSignal); % 진폭 스펙트럼
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