clear all;
clc;
close all;

global X;
X = [0,1,2,2,4,4;2,1,2,4,4,8];
w = [0; 0; 1; -1; 0; 0];

options = optimset('GradObj','on','MaxIter',100);
initialW = zeros(2,1);
[optW,functionVal,exitFlag] = fminunc(@costFunction,initialW,options);


% options = optimset('GradObj', 'on', 'MaxIter', 100);

% fun1 = @costFunctionRe;
% [optW1, functionVal1, exitFlag1] = fminunc(fun1, initialW, options);
