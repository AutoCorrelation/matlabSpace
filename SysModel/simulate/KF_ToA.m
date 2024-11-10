function KF_ToA()
format long e;
clear all;
% Initialization
iteration = 1e4;
num_sample = 11;
dt = 0.1;
load("LSE.mat");
load("Q.mat");
load("P.mat");

est_state = struct('var001', zeros(2,iteration,num_sample),...
    'var01', zeros(2,iteration,num_sample),...
    'var1', zeros(2,iteration,num_sample),...
    'var10', zeros(2,iteration,num_sample),...
    'var100', zeros(2,iteration,num_sample)...
    );

est_covariance = struct('var001', zeros(2,2,iteration,num_sample),...
    'var01', zeros(2,2,iteration,num_sample),...
    'var1', zeros(2,2,iteration,num_sample),...
    'var10', zeros(2,2,iteration,num_sample),...
    'var100', zeros(2,2,iteration,num_sample)...
    );

for iter = 1:iteration
    for num = 1:num_sample
        exactPos = [num-1;num-1];
        switch num
            case 1
                est_state.var001(:,iter,num) = [0;0];
                est_covariance.var001(:,:,iter,num) = P.var001;
                velocity_var001 = [0;0];

                est_state.var01(:,iter,num) = [0;0];
                est_covariance.var01(:,:,iter,num) = P.var01;
                velocity_var01 = [0;0];

                est_state.var1(:,iter,num) = [0;0];
                est_covariance.var1(:,:,iter,num) = P.var1;
                velocity_var1 = [0;0];

                est_state.var10(:,iter,num) = [0;0];
                est_covariance.var10(:,:,iter,num) = P.var10;
                velocity_var10 = [0;0];

                est_state.var100(:,iter,num) = [0;0];
                est_covariance.var100(:,:,iter,num) = P.var100;
                velocity_var100 = [0;0];
            case 2
                prev_est_state_var001 = est_state.var001(:,iter,num-1);
                est_covariance.var001(:,:,iter,num) = est_covariance.var001(:,:,iter,num-1);
                est_state.var001(:,iter,num) = LSE.var001(:,iter,num);
                velocity_var001 = (est_state.var001(:,iter,num) - prev_est_state_var001)./dt;
 
                prev_est_state_var01 = est_state.var01(:,iter,num-1);
                est_covariance.var01(:,:,iter,num) = est_covariance.var01(:,:,iter,num-1);
                est_state.var01(:,iter,num) = LSE.var01(:,iter,num);
                velocity_var01 = (est_state.var01(:,iter,num) - prev_est_state_var01)./dt;

                prev_est_state_var1 = est_state.var1(:,iter,num-1);
                est_covariance.var1(:,:,iter,num) = est_covariance.var1(:,:,iter,num-1);
                est_state.var1(:,iter,num) = LSE.var1(:,iter,num);
                velocity_var1 = (est_state.var1(:,iter,num) - prev_est_state_var1)./dt;

                prev_est_state_var10 = est_state.var10(:,iter,num-1);
                est_covariance.var10(:,:,iter,num) = est_covariance.var10(:,:,iter,num-1);
                est_state.var10(:,iter,num) = LSE.var10(:,iter,num);
                velocity_var10 = (est_state.var10(:,iter,num) - prev_est_state_var10)./dt;

                prev_est_state_var100 = est_state.var100(:,iter,num-1);
                est_covariance.var100(:,:,iter,num) = est_covariance.var100(:,:,iter,num-1);
                est_state.var100(:,iter,num) = LSE.var100(:,iter,num);
                velocity_var100 = (est_state.var100(:,iter,num) - prev_est_state_var100)./dt;
            case 3
                prev_est_state_var001 = est_state.var001(:,iter,num-1);
                est_covariance.var001(:,:,iter,num) = est_covariance.var001(:,:,iter,num-1);
                est_state.var001(:,iter,num) = LSE.var001(:,iter,num);
                velocity_var001 = (est_state.var001(:,iter,num) - prev_est_state_var001)./dt;
 
                prev_est_state_var01 = est_state.var01(:,iter,num-1);
                est_covariance.var01(:,:,iter,num) = est_covariance.var01(:,:,iter,num-1);
                est_state.var01(:,iter,num) = LSE.var01(:,iter,num);
                velocity_var01 = (est_state.var01(:,iter,num) - prev_est_state_var01)./dt;

                prev_est_state_var1 = est_state.var1(:,iter,num-1);
                est_covariance.var1(:,:,iter,num) = est_covariance.var1(:,:,iter,num-1);
                est_state.var1(:,iter,num) = LSE.var1(:,iter,num);
                velocity_var1 = (est_state.var1(:,iter,num) - prev_est_state_var1)./dt;

                prev_est_state_var10 = est_state.var10(:,iter,num-1);
                est_covariance.var10(:,:,iter,num) = est_covariance.var10(:,:,iter,num-1);
                est_state.var10(:,iter,num) = LSE.var10(:,iter,num);
                velocity_var10 = (est_state.var10(:,iter,num) - prev_est_state_var10)./dt;

                prev_est_state_var100 = est_state.var100(:,iter,num-1);
                est_covariance.var100(:,:,iter,num) = est_covariance.var100(:,:,iter,num-1);
                est_state.var100(:,iter,num) = LSE.var100(:,iter,num);
                velocity_var100 = (est_state.var100(:,iter,num) - prev_est_state_var100)./dt;
            otherwise
                prev_est_state_var001 = est_state.var001(:,iter,num-1);
                prev_estimate_cov_001 = est_covariance.var001(:,:,iter,num-1);
                [est_state_var001, est_covariance.var001(:,:,iter,num), kalman_gain_001] = kalmanFilter(prev_est_state_var001,prev_estimate_cov_001,velocity_var001,Q.var001,0,LSE.var001(:,iter,num));
                est_state.var001(:,iter,num) = est_state_var001;
                velocity_var001 = (est_state.var001(:,iter,num) - prev_est_state_var001)./dt;
                
                prev_est_state_var01 = est_state.var01(:,iter,num-1);
                prev_estimate_cov_001 = est_covariance.var01(:,:,iter,num-1);
                [est_state_var01, est_covariance.var01(:,:,iter,num), kalman_gain_001] = kalmanFilter(prev_est_state_var01,prev_estimate_cov_001,velocity_var01,Q.var01,0,LSE.var01(:,iter,num));
                est_state.var01(:,iter,num) = est_state_var01;
                velocity_var01 = (est_state.var01(:,iter,num) - prev_est_state_var01)./dt;

                prev_est_state_var1 = est_state.var1(:,iter,num-1);
                prev_estimate_cov_001 = est_covariance.var1(:,:,iter,num-1);
                [est_state_var1, est_covariance.var1(:,:,iter,num), kalman_gain_001] = kalmanFilter(prev_est_state_var1,prev_estimate_cov_001,velocity_var1,Q.var1,0,LSE.var1(:,iter,num));
                est_state.var1(:,iter,num) = est_state_var1;
                velocity_var1 = (est_state.var1(:,iter,num) - prev_est_state_var1)./dt;

                prev_est_state_var10 = est_state.var10(:,iter,num-1);
                prev_estimate_cov_001 = est_covariance.var10(:,:,iter,num-1);
                [est_state_var10, est_covariance.var10(:,:,iter,num), kalman_gain_001] = kalmanFilter(prev_est_state_var10,prev_estimate_cov_001,velocity_var10,Q.var10,0,LSE.var10(:,iter,num));
                est_state.var10(:,iter,num) = est_state_var10;
                velocity_var10 = (est_state.var10(:,iter,num) - prev_est_state_var10)./dt;

                prev_est_state_var100 = est_state.var100(:,iter,num-1);
                prev_estimate_cov_001 = est_covariance.var100(:,:,iter,num-1);
                [est_state_var100, est_covariance.var100(:,:,iter,num), kalman_gain_001] = kalmanFilter(prev_est_state_var100,prev_estimate_cov_001,velocity_var100,Q.var100,0,LSE.var100(:,iter,num));
                est_state.var100(:,iter,num) = est_state_var100;
                velocity_var100 = (est_state.var100(:,iter,num) - prev_est_state_var100)./dt;
        end

    end

end

save('est_state.mat','est_state');
n_variance = [1e-2; 1e-1; 1e0; 1e1; 1e2];
a = mean(est_covariance.var1,5);
for i = 1:num_sample
    buf(i,1) = trace(a(:,:,1,i));
end
stem((1:num_sample),buf);
title("estimation Error Covariance at variance 1")
xlabel("step")
ylabel("trace(P_k)")
end