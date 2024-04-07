clear all;
clc;
close all;

global X;
global Y;
X = [1.000, 0.895, 0.157, 0.124, 0.944, 0.365;
     1.000, 0.767, 0.582, 0.895, 0.220, 0.265;
     1.000, 0.630, 0.837, 0.566, 0.473, 0.375;
     1.000, 0.963, 0.590, 0.483, 0.245, 0.762];
w = [0; 1; 1; 1; 1; 1];
Y = [0; 1; 1; 1];
[jVal_s,gradientValue] = costFunctionRe(w);

hold on
grid on

    plot(1:2*1e5,jVal_s(1,:),"LineWidth",0.8);

legend("alpha = 0.01");
title("Costfuntion by Gradient Descent Alg.");
% options = optimset('GradObj', 'on', 'MaxIter', 100);
% initialW = zeros(2, 1);
% [optW, functionVal, exitFlag] = fminunc(@costFunction, initialW, options);

% [jVal, gradient] = costFunctionRe(W);


% options = optimset('GradObj', 'on', 'MaxIter', 100);
% 
% fun1 = @costFunctionRe;
% [optW1, functionVal1, exitFlag1] = fminunc(@costFunctionRe, w, options);
