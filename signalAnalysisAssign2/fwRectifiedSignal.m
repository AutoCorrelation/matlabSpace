function [fwrSignal] = fwRectifiedSignal(A,T,k,plotEnable)

L = length(k); %length of frequency range
fwrSignal = zeros(L,1); % Full-Wave Rectified Signal
phase = zeros(L,1); %zero column vector

%harmonics part
for i = 1:L
    % Fourier Coefficient
    if (rem(abs(k(i)),2)==0) % k 가 짝수일 때
        fwrSignal(i) = 2*A/((1-k(i)*k(i))*pi); %값 대입
    end
    % save its phase
    if fwrSignal(i)<0
        if k(i)<0
            phase(i) = angle(fwrSignal(i));
        else
            phase(i) = -angle(fwrSignal(i));
        end
    end
end
% DC (k=0)
fwrSignal(ceil(L/2)) = 2*A/pi;

% plot Part
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