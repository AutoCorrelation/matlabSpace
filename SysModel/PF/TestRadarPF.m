clear all

dt = 0.05;
t = 0:dt:20;

Nsamples = length(t);

Xsaved = zeros(Nsamples,3);
Zsaved = zeros(Nsamples,1);

for k = 1:Nsamples
    r = GetRadar(dt);

    [pos, vel, alt] = RadarPF(r, dt);

    Xsaved(k,:) = [pos, vel, alt];
    Zsaved(k) = r;
end

PosSaved = Xsaved(:,1);
VelSaved = Xsaved(:,2);
AltSaved = Xsaved(:,3);

t = 0:dt:Nsamples*dt-dt;
figure
subplot(3,1,1)
plot(t,PosSaved)

subplot(3,1,2)
plot(t,VelSaved)

subplot(3,1,3)
plot(t,AltSaved)
