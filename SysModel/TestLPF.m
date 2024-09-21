clear all
% close all
clc

Nsamples = 500;
Xsaved = zeros(Nsamples,1);
Xmsaved = zeros(Nsamples,1);

for k =1:Nsamples
    xm = getSonar();
    x = LPF(xm);

    Xsaved(k) = x;
    Xmsaved(k) = xm;
end

dt = 0.2;
t = 0:dt:(Nsamples-1)*dt;

figure
hold on
plot(t, Xmsaved, 'r.');
plot(t, Xsaved, 'b');
legend('Measured','LPF');
