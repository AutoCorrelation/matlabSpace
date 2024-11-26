clear
clc
close all

iteration=1e4;
tic

% preSimulation(iteration);
% LPF_ToA(iteration);
% KFpredict_ToA(iteration);
KF_ToA(iteration);
KF_ToA_DiagQ(iteration);
% KF_ToA_AdaptiveQ(iteration);
RMSE(iteration);

toc