clear, close all

AnchorMax1 = 10;
AnchorMax2 = 10;
Variance = [0.01; 0.1; 1; 10; 100];
iteration = 1e3;
Nsamples = 10;

NewMeasrue = false;
LPF_On = true;
minLPFerr
Anchor1 = [0;AnchorMax1];
Anchor2 = [0;0];
Anchor3 = [AnchorMax2;0];
Anchor4 = [AnchorMax1;AnchorMax2];

if(NewMeasrue)
    Measurement(iteration,Nsamples,AnchorMax1,AnchorMax2,Anchor1,Anchor2,Anchor3,Anchor4);
end

if(LPF_On)
    for a=1:9
        alpha = a/10;
    [Err_cost,ErrLpf_cost] = LPF_ToA(iteration,Nsamples,AnchorMax1,AnchorMax2,alpha);
        buf(:,a) = ErrLpf_cost;
    end
    minLPFerr = min(buf,[],2);
else
    Err_cost = ToA(iteration,Nsamples,AnchorMax1,AnchorMax2);
end

%% plots
figure
semilogx(Variance,Err_cost)
title("ToA Loc Err by Measurement Noise")
xlabel("variance")
ylabel("Err")
legend("ToA")
grid on

if(LPF_On)
    hold on
    semilogx(Variance,minLPFerr);
    legend("LPF");
end

figure
title("exact Pos-2dim");
ex = load("exactPosX.txt");
ey = load("exactPosY.txt");
stem(ex(1,:),ey(1,:));
