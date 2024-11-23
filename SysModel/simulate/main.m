clear
clc
close all

iteration=1e3;
 
preSimulation(iteration);
KFpredict_ToA(iteration);
LPF_ToA(iteration);
KF_ToA(iteration);
KF_ToA_AdaptiveR(iteration);
KF_ToA_AdaptiveQ(iteration);

RMSE(iteration);