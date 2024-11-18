clear
clc
% close all

iteration=1e3;
 
AnchorMeasure(iteration);
process_Simulation(iteration);
LPF_ToA(iteration);
KFpredict_ToA(iteration);
KF_ToA(iteration);
RMSE(iteration);