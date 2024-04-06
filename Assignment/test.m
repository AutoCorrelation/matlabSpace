options = optimset('GradObj','on','MaxIter',100);
initialW = zeros(2,1);
[optW,functionVal,exitFlag] = fminunc(@costFunction,initialW,options);