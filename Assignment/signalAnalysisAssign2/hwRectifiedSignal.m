function [hwrSignal] = hwRectifiedSignal(A,T,k,plotEnable)

L = length(k); %length of frequency range
hwrSignal = zeros(L,1); % Half-Wave Rectified Signal
phase = zeros(L,1);

%harmonics part
for i = 1:L
    % Fourier Coefficient
    if (rem(abs(k(i)),2)==0) % k 가 짝수일 때
        hwrSignal(i) = A/((1-k(i)*k(i))*pi); %값 대입
    end
    % save its phase
    if hwrSignal(i)<0
        if k(i)<0
            phase(i) = angle(hwrSignal(i));
        else
            phase(i) = -angle(hwrSignal(i));
        end
    end
end

% when k = +1, -1
%  0 (DC)
hwrSignal(ceil(L/2)+1) = -1j*A/4;
hwrSignal(ceil(L/2)) = A/pi;
hwrSignal(ceil(L/2)-1) = 1j*A/4;

% plot Part
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