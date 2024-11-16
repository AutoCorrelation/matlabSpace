function RMSE()
close all
load("LSE.mat");
load("est_state.mat")
load("lpf_state.mat")

% n_variance = [1e-2; 1e-1; 1e0; 1e1; 1e2];
n_variance = [0.01; 0.1; 1; 10; 100];

iteration = 1e4;
num_sample = 11;
mse = zeros(length(n_variance),1);
lpf_mse_buf = zeros(length(n_variance),9);
KF_mse = zeros(length(n_variance),1);

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
        for a = 1:9
            lpf_mse_buf(:,a) = lpf_mse_buf(:,a) + [...
                norm(lpf_state.var001(:,iter,num,a)-exactPos);...
                norm(lpf_state.var01(:,iter,num,a)-exactPos);...
                norm(lpf_state.var1(:,iter,num,a)-exactPos);...
                norm(lpf_state.var10(:,iter,num,a)-exactPos);...
                norm(lpf_state.var100(:,iter,num,a)-exactPos)...
                ];
        end

        KF_mse = KF_mse + [...
            norm(est_state.var001(:,iter,num)-exactPos);...
            norm(est_state.var01(:,iter,num)-exactPos);...
            norm(est_state.var1(:,iter,num)-exactPos);...
            norm(est_state.var10(:,iter,num)-exactPos);...
            norm(est_state.var100(:,iter,num)-exactPos)...
            ];
    end
end
mse = mse./(iteration * num_sample);
[lpf_mse_min,optimal_alpha] = min(lpf_mse_buf,[],2);
lpf_mse = lpf_mse_min./(iteration * num_sample);
KF_mse = KF_mse./(iteration * num_sample);

figure(1)
semilogx(n_variance,mse);
hold on
semilogx(n_variance,lpf_mse);
semilogx(n_variance,KF_mse);
title("err according to measurement noise");
xlabel("variance");
ylabel("err");
legend("ToA","LPF+ToA","KF(predict)+ToA");
grid on
disp("optimal alpha: "+optimal_alpha);
end