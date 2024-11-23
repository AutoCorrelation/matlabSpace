function KF_ToA_modified(iteration)

% Initialization
num_sample = 11;
dt = 0.1;
load("LSE.mat");
load("Q.mat");
load("P.mat");
load("Z.mat");
load("R.mat");
load("meanSysnoise.mat");

stepR_est_state = struct('var001', zeros(2,iteration,num_sample),...
    'var01', zeros(2,iteration,num_sample),...
    'var1', zeros(2,iteration,num_sample),...
    'var10', zeros(2,iteration,num_sample),...
    'var100', zeros(2,iteration,num_sample)...
    );

% est_covariance = struct('var001', zeros(2,2,iteration,num_sample),...
%     'var01', zeros(2,2,iteration,num_sample),...
%     'var1', zeros(2,2,iteration,num_sample),...
%     'var10', zeros(2,2,iteration,num_sample),...
%     'var100', zeros(2,2,iteration,num_sample)...
%     );

% KalmanGain = struct('var001', zeros(2,6,iteration,num_sample),...
%     'var01', zeros(2,6,iteration,num_sample),...
%     'var1', zeros(2,6,iteration,num_sample),...
%     'var10', zeros(2,6,iteration,num_sample),...
%     'var100', zeros(2,6,iteration,num_sample)...
%     );

for iter = 1:iteration
    for num = 1:num_sample
        exactPos = [num-1;num-1];
        switch num
            case 1
                stepR_est_state.var001(:,iter,num) = [0;0];
                est_covariance.var001(:,:,iter,num) = P.var001;
                velocity_var001 = [0;0];
                
                stepR_est_state.var01(:,iter,num) = [0;0];
                est_covariance.var01(:,:,iter,num) = P.var01;
                velocity_var01 = [0;0];
                
                stepR_est_state.var1(:,iter,num) = [0;0];
                est_covariance.var1(:,:,iter,num) = P.var1;
                velocity_var1 = [0;0];
                
                stepR_est_state.var10(:,iter,num) = [0;0];
                est_covariance.var10(:,:,iter,num) = P.var10;
                velocity_var10 = [0;0];
                
                stepR_est_state.var100(:,iter,num) = [0;0];
                est_covariance.var100(:,:,iter,num) = P.var100;
                velocity_var100 = [0;0];
            case 2
                prev_stepR_est_state_var001 = stepR_est_state.var001(:,iter,num-1);
                est_covariance.var001(:,:,iter,num) = est_covariance.var001(:,:,iter,num-1);
                stepR_est_state.var001(:,iter,num) = LSE.var001(:,iter,num);
                velocity_var001 = (stepR_est_state.var001(:,iter,num) - prev_stepR_est_state_var001)./dt;
                
                prev_stepR_est_state_var01 = stepR_est_state.var01(:,iter,num-1);
                est_covariance.var01(:,:,iter,num) = est_covariance.var01(:,:,iter,num-1);
                stepR_est_state.var01(:,iter,num) = LSE.var01(:,iter,num);
                velocity_var01 = (stepR_est_state.var01(:,iter,num) - prev_stepR_est_state_var01)./dt;
                
                prev_stepR_est_state_var1 = stepR_est_state.var1(:,iter,num-1);
                est_covariance.var1(:,:,iter,num) = est_covariance.var1(:,:,iter,num-1);
                stepR_est_state.var1(:,iter,num) = LSE.var1(:,iter,num);
                velocity_var1 = (stepR_est_state.var1(:,iter,num) - prev_stepR_est_state_var1)./dt;
                
                prev_stepR_est_state_var10 = stepR_est_state.var10(:,iter,num-1);
                est_covariance.var10(:,:,iter,num) = est_covariance.var10(:,:,iter,num-1);
                stepR_est_state.var10(:,iter,num) = LSE.var10(:,iter,num);
                velocity_var10 = (stepR_est_state.var10(:,iter,num) - prev_stepR_est_state_var10)./dt;
                
                prev_stepR_est_state_var100 = stepR_est_state.var100(:,iter,num-1);
                est_covariance.var100(:,:,iter,num) = est_covariance.var100(:,:,iter,num-1);
                stepR_est_state.var100(:,iter,num) = LSE.var100(:,iter,num);
                velocity_var100 = (stepR_est_state.var100(:,iter,num) - prev_stepR_est_state_var100)./dt;
            case 3
                prev_stepR_est_state_var001 = stepR_est_state.var001(:,iter,num-1);
                est_covariance.var001(:,:,iter,num) = est_covariance.var001(:,:,iter,num-1);
                stepR_est_state.var001(:,iter,num) = LSE.var001(:,iter,num);
                velocity_var001 = (stepR_est_state.var001(:,iter,num) - prev_stepR_est_state_var001)./dt;
                
                prev_stepR_est_state_var01 = stepR_est_state.var01(:,iter,num-1);
                est_covariance.var01(:,:,iter,num) = est_covariance.var01(:,:,iter,num-1);
                stepR_est_state.var01(:,iter,num) = LSE.var01(:,iter,num);
                velocity_var01 = (stepR_est_state.var01(:,iter,num) - prev_stepR_est_state_var01)./dt;
                
                prev_stepR_est_state_var1 = stepR_est_state.var1(:,iter,num-1);
                est_covariance.var1(:,:,iter,num) = est_covariance.var1(:,:,iter,num-1);
                stepR_est_state.var1(:,iter,num) = LSE.var1(:,iter,num);
                velocity_var1 = (stepR_est_state.var1(:,iter,num) - prev_stepR_est_state_var1)./dt;
                
                prev_stepR_est_state_var10 = stepR_est_state.var10(:,iter,num-1);
                est_covariance.var10(:,:,iter,num) = est_covariance.var10(:,:,iter,num-1);
                stepR_est_state.var10(:,iter,num) = LSE.var10(:,iter,num);
                velocity_var10 = (stepR_est_state.var10(:,iter,num) - prev_stepR_est_state_var10)./dt;
                
                prev_stepR_est_state_var100 = stepR_est_state.var100(:,iter,num-1);
                est_covariance.var100(:,:,iter,num) = est_covariance.var100(:,:,iter,num-1);
                stepR_est_state.var100(:,iter,num) = LSE.var100(:,iter,num);
                velocity_var100 = (stepR_est_state.var100(:,iter,num) - prev_stepR_est_state_var100)./dt;
            otherwise
                prev_stepR_est_state_var001 = stepR_est_state.var001(:,iter,num-1);
                prev_estimate_cov_001 = est_covariance.var001(:,:,iter,num-1);
                [stepR_est_state_var001, est_covariance_var001, kalman_gain_001] = kalmanFilter(prev_stepR_est_state_var001,prev_estimate_cov_001,velocity_var001,Q.var001,Rmean.var001(:,:,num),Z.var001(:,1,iter,num),meanSysnoise.var001);
                stepR_est_state.var001(:,iter,num) = stepR_est_state_var001;
                est_covariance.var001(:,:,iter,num) = est_covariance_var001;
                velocity_var001 = (stepR_est_state.var001(:,iter,num) - prev_stepR_est_state_var001)./dt;
                KalmanGain.var001(:,:,iter,num) = kalman_gain_001;
                
                prev_stepR_est_state_var01 = stepR_est_state.var01(:,iter,num-1);
                prev_estimate_cov_001 = est_covariance.var01(:,:,iter,num-1);
                [stepR_est_state_var01, est_covariance_var01, kalman_gain_01] = kalmanFilter(prev_stepR_est_state_var01,prev_estimate_cov_001,velocity_var01,Q.var01,Rmean.var01(:,:,num),Z.var01(:,1,iter,num),meanSysnoise.var01);
                stepR_est_state.var01(:,iter,num) = stepR_est_state_var01;
                est_covariance.var01(:,:,iter,num) = est_covariance_var01;
                velocity_var01 = (stepR_est_state.var01(:,iter,num) - prev_stepR_est_state_var01)./dt;
                KalmanGain.var01(:,:,iter,num) = kalman_gain_01;
                
                prev_stepR_est_state_var1 = stepR_est_state.var1(:,iter,num-1);
                prev_estimate_cov_001 = est_covariance.var1(:,:,iter,num-1);
                [stepR_est_state_var1, est_covariance_var1, kalman_gain_1] = kalmanFilter(prev_stepR_est_state_var1,prev_estimate_cov_001,velocity_var1,Q.var1,Rmean.var1(:,:,num),Z.var1(:,1,iter,num),meanSysnoise.var1);
                stepR_est_state.var1(:,iter,num) = stepR_est_state_var1;
                est_covariance.var1(:,:,iter,num) = est_covariance_var1;
                velocity_var1 = (stepR_est_state.var1(:,iter,num) - prev_stepR_est_state_var1)./dt;
                KalmanGain.var1(:,:,iter,num) = kalman_gain_1;
                
                prev_stepR_est_state_var10 = stepR_est_state.var10(:,iter,num-1);
                prev_estimate_cov_001 = est_covariance.var10(:,:,iter,num-1);
                [stepR_est_state_var10, est_covariance_var10, kalman_gain_10] = kalmanFilter(prev_stepR_est_state_var10,prev_estimate_cov_001,velocity_var10,Q.var10,Rmean.var10(:,:,num),Z.var10(:,1,iter,num),meanSysnoise.var10);
                stepR_est_state.var10(:,iter,num) = stepR_est_state_var10;
                est_covariance.var10(:,:,iter,num) = est_covariance_var10;
                velocity_var10 = (stepR_est_state.var10(:,iter,num) - prev_stepR_est_state_var10)./dt;
                KalmanGain.var10(:,:,iter,num) = kalman_gain_10;
                
                prev_stepR_est_state_var100 = stepR_est_state.var100(:,iter,num-1);
                prev_estimate_cov_001 = est_covariance.var100(:,:,iter,num-1);
                [stepR_est_state_var100, est_covariance_var100, kalman_gain_100] = kalmanFilter(prev_stepR_est_state_var100,prev_estimate_cov_001,velocity_var100,Q.var100,Rmean.var100(:,:,num),Z.var100(:,1,iter,num),meanSysnoise.var100);
                stepR_est_state.var100(:,iter,num) = stepR_est_state_var100;
                est_covariance.var100(:,:,iter,num) = est_covariance_var100;
                velocity_var100 = (stepR_est_state.var100(:,iter,num) - prev_stepR_est_state_var100)./dt;
                KalmanGain.var100(:,:,iter,num) = kalman_gain_100;
        end
        
    end
    
end

save('stepR_est_state.mat','stepR_est_state');
% save('est_covariance.mat','est_covariance');
% save('KalmanGain.mat','KalmanGain');
n_variance = [1e-2; 1e-1; 1e0; 1e1; 1e2];
a = mean(est_covariance.var01,3);
for i = 1:num_sample
    buf(i,1) = trace(a(:,:,1,i));
end
figure;
stem((1:num_sample),buf);
title("estimation Error Covariance at variance 1")
xlabel("step")
ylabel("trace(P_k)")

end