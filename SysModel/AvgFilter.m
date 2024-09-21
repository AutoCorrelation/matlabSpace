function avg = AvgFilter(x)
%UNTITLED 이 함수의 요약 설명 위치
%   자세한 설명 위치
persistent prevAvg k
persistent firstRun

if isempty(firstRun)
    k=1;
    prevAvg=0;

    firstRun = 1;
end

alpha = (k-1)/k;

avg = alpha*prevAvg + (1-alpha)*x;

prevAvg = avg;
k = k+1;