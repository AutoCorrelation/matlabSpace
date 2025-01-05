clear all
 
dt = 0.05;
t = 0:dt:20;

Nsmaples = length(t);

Xsaved = zeros(Nsmaples, 3);
Zsaved = zeros(Nsmaples, 1);

for k=1:Nsmaples
    r = GetRadar(dt);

    [pos, vel, alt] = RadarUKF(r, dt);

    Xsaved(k,:) = [pos, vel, alt];
    Zsaved(k) = r;
end

PosSaved = Xsaved(:,1);
VelSaved = Xsaved(:,2);
AltSaved = Xsaved(:,3);

t = 0:dt:Nsmaples*dt-dt;

figure;
subplot(3,1,1);
plot(t, PosSaved)
title('Position')

subplot(3,1,2);
plot(t, VelSaved)
title('Velocity')

subplot(3,1,3);
plot(t, AltSaved)
title('Altitude')