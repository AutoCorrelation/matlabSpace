function [x] = LPF(z,j)
%UNTITLED2 이 함수의 요약 설명 위치
%   자세한 설명 위치
if(j>2)
    LPF001 = 0.9*ToA_State001(:,j-1)+0.1*ToA_State001(:,j);
    LPF01 = 0.9*ToA_State01(:,j-1)+0.1*ToA_State01(:,j);
    LPF1 = 0.9*ToA_State1(:,j-1)+0.1*ToA_State1(:,j);
    LPF10 = 0.9*ToA_State10(:,j-1)+0.1*ToA_State10(:,j);
    LPF100 = 0.9*ToA_State100(:,j-1)+0.1*ToA_State100(:,j);
else
    LPF001 = ToA_State001(:,j);
    LPF001 = ToA_State001(:,j);
    LPF001 = ToA_State001(:,j);
    LPF001 = ToA_State001(:,j);
    LPF001 = ToA_State001(:,j);
end


end