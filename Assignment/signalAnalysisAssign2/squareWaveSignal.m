function [suqareSignal] = squareWaveSignal(A,T,k,plotEnable)

L = length(k); %length of frequency range
suqareSignal = zeros(L,1); % Full-Wave Rectified Signal
% phase = zeros(L,1);

%harmonics part
for num1 = 1:L
    if (rem(abs(k(num1)),2)==1) % k 가 홀수 일때
        suqareSignal(num1) = -1j*2*A/(k(num1)*pi); %값 대입
    end
    %  if abs(suqareSignal(num1)
    % if k(num1)<0
    %     phase(num1) = angle(suqareSignal(num1));
    % else
    %     phase(num1) = -angle(suqareSignal(num1));
    % end
    %  end
end

% DC (k=0)
suqareSignal(ceil(L/2)) = 0;
% 한번에 위상 저장
phase = angle(suqareSignal);

% plot Part
if plotEnable == 1
    grid on
    subplot(2,1,1);
    stem(k,abs(suqareSignal)); % 진폭 스펙트럼
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