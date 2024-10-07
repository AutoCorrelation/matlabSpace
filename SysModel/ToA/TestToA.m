%set Anchor Location
clear
close all

AnchorMax1 = 10;
AnchorMax2 = 10;
Variance = [0.01; 0.1; 1; 10; 100];
iteration = 1e3;
Nsamples = 10;

NewMeasrue = false;

Anchor1 = [0;AnchorMax1];
Anchor2 = [0;0];
Anchor3 = [AnchorMax2;0];
Anchor4 = [AnchorMax1;AnchorMax2];

if(NewMeasrue)
    Measurement(iteration,Nsamples,AnchorMax1,AnchorMax2,Anchor1,Anchor2,Anchor3,Anchor4);
end

Err_cost = ToA(iteration,Nsamples,AnchorMax1,AnchorMax2);

figure
semilogx(Variance,Err_cost)
title("ToA Loc Err by Measurement Noise")
xlabel("variance")
ylabel("Err")
legend("ToA")

grid on