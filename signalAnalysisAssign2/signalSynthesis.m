function [] = signalSynthesis(A,T,k,FourierCoefficient)
X_k=FourierCoefficient;
period_Sampling = 0.001;
w = pi/T;
N = [3,10,20,40];
t = -6:period_Sampling:6;

for num1 = 1:length(N)
    test = zeros(length(t),1);
    for num2 = -N(num1):N(num1)
        k_index=ceil(length(k)/2+num2);
        test=test+X_k(k_index)*exp(1j*(num2)*w*t');
    end
    subplot(2,2,num1)
    plot(t,test);
end
end
