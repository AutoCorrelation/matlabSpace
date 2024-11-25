clear
clc
close all

iteration=1e4;
 
preSimulation(iteration);
LPF_ToA(iteration);
KFpredict_ToA(iteration);
KF_ToA(iteration);
KF_ToA_AdaptiveR(iteration);
KF_ToA_AdaptiveQ(iteration);

RMSE(iteration);