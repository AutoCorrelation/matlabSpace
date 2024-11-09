function MSE()
load("ToA.mat");
n_variance = [1e-2; 1e-1; 1e0; 1e1; 1e2];
iteration = 1e4;
num_sample = 11;

mse = zeros(length(n_variance),1);

for iter = 1:iteration
    for num = 1:num_sample
        exactPos = [num-1;num-1];
        mse = mse + [...
            norm(LSE.var001(:,iter,num)-exactPos);...
            norm(LSE.var01(:,iter,num)-exactPos);...
            norm(LSE.var1(:,iter,num)-exactPos);...
            norm(LSE.var10(:,iter,num)-exactPos);...
            norm(LSE.var100(:,iter,num)-exactPos)...
            ];
    end
end
mse = mse./(iteration * num_sample);

figure(1)
semilogx(n_variance,mse);
title("ToA err according to measurement noise");
xlabel("variance");
ylabel("err");
legend("ToA");
grid on

        
        
        
        
        
