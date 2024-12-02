close all;
clear
clc
iteration=1e4;

preSimulation(iteration); %include the preSimulation and ToA functions
optimal_Lpf_ToA(iteration);
optimal_Predict_ToA(iteration);
KF_ToA(iteration);
KF_ToA_DiagR(iteration);

ResultofSimulation(iteration);

