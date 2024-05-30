function [] = harmonicsSynthesis(A,T,k,FourierCoefficient)
X_k=FourierCoefficient; 
period_Sampling = 0.001;
w = 2*pi/T;
N = [3,10,20,40];
t = -6:period_Sampling:6;
%N의 배열의 요소 갯수만큼 반복함
for num1 = 1:length(N)
    test = zeros(length(t),1); %빈 배열 생성
    for num2 = -N(num1):N(num1) %-N~N까지 반복하며 더한다.
        k_index=ceil(length(k)/2+num2);
        % k=0일 때도 알아서 합성
        test=test+X_k(k_index)*exp(1j*(num2)*w*t');
    end
    subplot(2,2,num1) 
    plot(t,test);
    title(sprintf("N=%g",N(num1)));
    xlabel('T');
    ylabel('A')
end
end
