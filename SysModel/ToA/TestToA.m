clear, close all

AnchorMax1 = 10;
AnchorMax2 = 10;
Variance = [0.01; 0.1; 1; 10; 100];
iteration = 1e3;
Nsamples = 10;


Anchor1 = [0;AnchorMax1];
Anchor2 = [0;0];
Anchor3 = [AnchorMax2;0];
Anchor4 = [AnchorMax1;AnchorMax2];


NewMeasrue = true; % true: Record New measurement / false: Use previously recorded measurements

if(NewMeasrue)
    %{
    @fn Measurement
    @param iteration, number of samples, Anchor info.
    @brief "Record measurement from each anchor and save as a .txt file.
    @return None
    %}
    Measurement(iteration,Nsamples,Anchor1,Anchor2,Anchor3,Anchor4);
end

%{
@fn ToA
@param iteration, number of samples, Anchor info.
@brief Apply ToA(Time of Arrival) Algorithm
@return Mean of Location Error Matrix for each noise variance
%}
Err_cost = ToA(iteration,Nsamples,AnchorMax1,AnchorMax2);



figure
semilogx(Variance,Err_cost);
title("ToA Loc Err by Measurement Noise");
xlabel("variance");
ylabel("Err");
legend("ToA");
grid on

figure
title("exact Pos-2dim");
ex = load("exactPosX.txt");
ey = load("exactPosY.txt");
stem(ex(1,:),ey(1,:));
