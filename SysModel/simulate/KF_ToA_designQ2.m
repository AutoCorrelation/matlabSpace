function KF_ToA_designQ2(iteration)
% variables
num_sample = 11;
dt = 0.1;
load('LSE.mat');
load('Q.mat');
load('P.mat');
load('Z.mat');
load('Rconst.mat');
load('meanSysnoise.mat');
%
gamma=[0.1320 0.1260 0.1260 0.1240 0.0720]; %OPTIMIZED AT Q.DIAG
%
% Q.var001 = eig(Q.var001,'matrix');
% Q.var01 = eig(Q.var01,'matrix');
% Q.var1 = eig(Q.var1,'matrix');
% Q.var10 = eig(Q.var10,'matrix');
% Q.var100 = eig(Q.var100,'matrix');
% 
% P.var001 = diag(eig(P.var001));
% P.var01 = diag(eig(P.var01)); 
% P.var1 = diag(eig(P.var1));
% P.var10 = diag(eig(P.var10));
% P.var100 = diag(eig(P.var100));
Qbuf = Q;
DesignQ2_est_state = struct('var001', zeros(2,iteration,num_sample),...
    'var01', zeros(2,iteration,num_sample),...
    'var1', zeros(2,iteration,num_sample),...
    'var10', zeros(2,iteration,num_sample),...
    'var100', zeros(2,iteration,num_sample)...
    );

DesignQ2_est_covariance = struct('var001', zeros(2,2,iteration,num_sample),...
    'var01', zeros(2,2,iteration,num_sample),...
    'var1', zeros(2,2,iteration,num_sample),...
    'var10', zeros(2,2,iteration,num_sample),...
    'var100', zeros(2,2,iteration,num_sample)...
    );

DesignQ2_KalmanGain = struct('var001', zeros(2,6,iteration,num_sample),...
    'var01', zeros(2,6,iteration,num_sample),...
    'var1', zeros(2,6,iteration,num_sample),...
    'var10', zeros(2,6,iteration,num_sample),...
    'var100', zeros(2,6,iteration,num_sample)...
    );

for iter = 1:iteration
    Q=Qbuf;
    for num = 1:num_sample
        exactPos = [num-1;num-1];
        switch num
            case 1
                DesignQ2_est_state.var001(:,iter,num) = [0;0];
                DesignQ2_est_covariance.var001(:,:,iter,num) = P.var001;
                velocity_var001 = [0;0];

                DesignQ2_est_state.var01(:,iter,num) = [0;0];
                DesignQ2_est_covariance.var01(:,:,iter,num) = P.var01;
                velocity_var01 = [0;0];

                DesignQ2_est_state.var1(:,iter,num) = [0;0];
                DesignQ2_est_covariance.var1(:,:,iter,num) = P.var1;
                velocity_var1 = [0;0];

                DesignQ2_est_state.var10(:,iter,num) = [0;0];
                DesignQ2_est_covariance.var10(:,:,iter,num) = P.var10;
                velocity_var10 = [0;0];

                DesignQ2_est_state.var100(:,iter,num) = [0;0];
                DesignQ2_est_covariance.var100(:,:,iter,num) = P.var100;
                velocity_var100 = [0;0];
            case 2
                DesignQ2_est_covariance.var001(:,:,iter,num) = DesignQ2_est_covariance.var001(:,:,iter,num-1);
                DesignQ2_est_covariance.var01(:,:,iter,num) = DesignQ2_est_covariance.var01(:,:,iter,num-1);
                DesignQ2_est_covariance.var1(:,:,iter,num) = DesignQ2_est_covariance.var1(:,:,iter,num-1);
                DesignQ2_est_covariance.var10(:,:,iter,num) = DesignQ2_est_covariance.var10(:,:,iter,num-1);
                DesignQ2_est_covariance.var100(:,:,iter,num) = DesignQ2_est_covariance.var100(:,:,iter,num-1);

                DesignQ2_est_state.var001(:,iter,num) = LSE.var001(:,iter,num);
                DesignQ2_est_state.var01(:,iter,num) = LSE.var01(:,iter,num);
                DesignQ2_est_state.var1(:,iter,num) = LSE.var1(:,iter,num);
                DesignQ2_est_state.var10(:,iter,num) = LSE.var10(:,iter,num);
                DesignQ2_est_state.var100(:,iter,num) = LSE.var100(:,iter,num);
            case 3
                DesignQ2_est_covariance.var001(:,:,iter,num) = DesignQ2_est_covariance.var001(:,:,iter,num-1);
                DesignQ2_est_covariance.var01(:,:,iter,num) = DesignQ2_est_covariance.var01(:,:,iter,num-1);
                DesignQ2_est_covariance.var1(:,:,iter,num) = DesignQ2_est_covariance.var1(:,:,iter,num-1);
                DesignQ2_est_covariance.var10(:,:,iter,num) = DesignQ2_est_covariance.var10(:,:,iter,num-1);
                DesignQ2_est_covariance.var100(:,:,iter,num) = DesignQ2_est_covariance.var100(:,:,iter,num-1);

                DesignQ2_est_state.var001(:,iter,num) = LSE.var001(:,iter,num);
                DesignQ2_est_state.var01(:,iter,num) = LSE.var01(:,iter,num);
                DesignQ2_est_state.var1(:,iter,num) = LSE.var1(:,iter,num);
                DesignQ2_est_state.var10(:,iter,num) = LSE.var10(:,iter,num);
                DesignQ2_est_state.var100(:,iter,num) = LSE.var100(:,iter,num);

                velocity_var001 = (DesignQ2_est_state.var001(:,iter,num) - DesignQ2_est_state.var001(:,iter,num-1))./dt;
                velocity_var01 = (DesignQ2_est_state.var01(:,iter,num) - DesignQ2_est_state.var01(:,iter,num-1))./dt;
                velocity_var1 = (DesignQ2_est_state.var1(:,iter,num) - DesignQ2_est_state.var1(:,iter,num-1))./dt;
                velocity_var10 = (DesignQ2_est_state.var10(:,iter,num) - DesignQ2_est_state.var10(:,iter,num-1))./dt;
                velocity_var100 = (DesignQ2_est_state.var100(:,iter,num) - DesignQ2_est_state.var100(:,iter,num-1))./dt;
            otherwise
                [DesignQ2_est_state_var001, DesignQ2_est_covariance_var001, kalman_gain_001] =...
                    kalmanFilter(DesignQ2_est_state.var001(:,iter,num-1),DesignQ2_est_covariance.var001(:,:,iter,num-1),velocity_var001,Q.var001,Rconst.var001,Z.var001(:,1,iter,num),meanSysnoise.var001);
                [DesignQ2_est_state_var01, DesignQ2_est_covariance_var01, kalman_gain_01] =...
                    kalmanFilter(DesignQ2_est_state.var01(:,iter,num-1),DesignQ2_est_covariance.var01(:,:,iter,num-1),velocity_var01,Q.var01,Rconst.var01,Z.var01(:,1,iter,num),meanSysnoise.var01);
                [DesignQ2_est_state_var1, DesignQ2_est_covariance_var1, kalman_gain_1] =...
                    kalmanFilter(DesignQ2_est_state.var1(:,iter,num-1),DesignQ2_est_covariance.var1(:,:,iter,num-1),velocity_var1,Q.var1,Rconst.var1,Z.var1(:,1,iter,num),meanSysnoise.var1);
                [DesignQ2_est_state_var10, DesignQ2_est_covariance_var10, kalman_gain_10] =...
                    kalmanFilter(DesignQ2_est_state.var10(:,iter,num-1),DesignQ2_est_covariance.var10(:,:,iter,num-1),velocity_var10,Q.var10,Rconst.var10,Z.var10(:,1,iter,num),meanSysnoise.var10);
                [DesignQ2_est_state_var100, DesignQ2_est_covariance_var100, kalman_gain_100] =...
                    kalmanFilter(DesignQ2_est_state.var100(:,iter,num-1),DesignQ2_est_covariance.var100(:,:,iter,num-1),velocity_var100,Q.var100,Rconst.var100,Z.var100(:,1,iter,num),meanSysnoise.var100);

                DesignQ2_est_state.var001(:,iter,num) = DesignQ2_est_state_var001;
                DesignQ2_est_state.var01(:,iter,num) = DesignQ2_est_state_var01;
                DesignQ2_est_state.var1(:,iter,num) = DesignQ2_est_state_var1;
                DesignQ2_est_state.var10(:,iter,num) = DesignQ2_est_state_var10;
                DesignQ2_est_state.var100(:,iter,num) = DesignQ2_est_state_var100;

                DesignQ2_est_covariance.var001(:,:,iter,num) = DesignQ2_est_covariance_var001;
                DesignQ2_est_covariance.var01(:,:,iter,num) = DesignQ2_est_covariance_var01;
                DesignQ2_est_covariance.var1(:,:,iter,num) = DesignQ2_est_covariance_var1;
                DesignQ2_est_covariance.var10(:,:,iter,num) = DesignQ2_est_covariance_var10;
                DesignQ2_est_covariance.var100(:,:,iter,num) = DesignQ2_est_covariance_var100;

                DesignQ2_KalmanGain.var001(:,:,iter,num) = kalman_gain_001;
                DesignQ2_KalmanGain.var01(:,:,iter,num) = kalman_gain_01;
                DesignQ2_KalmanGain.var1(:,:,iter,num) = kalman_gain_1;
                DesignQ2_KalmanGain.var10(:,:,iter,num) = kalman_gain_10;
                DesignQ2_KalmanGain.var100(:,:,iter,num) = kalman_gain_100;

                velocity_var001 = (DesignQ2_est_state.var001(:,iter,num) - DesignQ2_est_state.var001(:,iter,num-1))./dt;
                velocity_var01 = (DesignQ2_est_state.var01(:,iter,num) - DesignQ2_est_state.var01(:,iter,num-1))./dt;
                velocity_var1 = (DesignQ2_est_state.var1(:,iter,num) - DesignQ2_est_state.var1(:,iter,num-1))./dt;
                velocity_var10 = (DesignQ2_est_state.var10(:,iter,num) - DesignQ2_est_state.var10(:,iter,num-1))./dt;
                velocity_var100 = (DesignQ2_est_state.var100(:,iter,num) - DesignQ2_est_state.var100(:,iter,num-1))./dt;
                
                Q.var001 = Q.var001*exp(-gamma(1)*(num-3));
                Q.var01 = Q.var01*exp(-gamma(2)*(num-3));
                Q.var1 = Q.var1*exp(-gamma(3)*(num-3));
                Q.var10 = Q.var10*exp(-gamma(4)*(num-3));
                Q.var100 = Q.var100*exp(-gamma(5)*(num-3));
        end
    end
end

save('DesignQ2_est_state.mat','DesignQ2_est_state');
% save('DesignQ2_est_covariance.mat','DesignQ2_est_covariance');
% save('DesignQ2_KalmanGain.mat','DesignQ2_KalmanGain');
n_variance = [1e-2; 1e-1; 1e0; 1e1; 1e2];
a = mean(DesignQ2_est_covariance.var1,3);
for i = 1:num_sample
    buf(i,1) = norm(a(:,:,1,i));
end
figure;
stem((1:num_sample),buf);
title('norm(P Diag) KF')
xlabel('step')
ylabel('norm(P_k)')

end