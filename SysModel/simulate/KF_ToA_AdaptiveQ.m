function KF_ToA_AdaptiveQ(iteration)
% variables
num_sample = 11;
dt = 0.1;
alphamax = 9;
load("LSE.mat");
load("Q.mat");
load("P.mat");
load("Z.mat");
load("Rmean.mat");
load("meanSysnoise.mat");

AdaptiveQ_est_state = struct('var001', zeros(2,iteration,num_sample,alphamax),...
    'var01', zeros(2,iteration,num_sample,alphamax),...
    'var1', zeros(2,iteration,num_sample,alphamax),...
    'var10', zeros(2,iteration,num_sample,alphamax),...
    'var100', zeros(2,iteration,num_sample,alphamax)...
    );

AdaptiveQ_est_covariance = struct('var001', zeros(2,2,iteration,num_sample,alphamax),...
    'var01', zeros(2,2,iteration,num_sample,alphamax),...
    'var1', zeros(2,2,iteration,num_sample,alphamax),...
    'var10', zeros(2,2,iteration,num_sample,alphamax),...
    'var100', zeros(2,2,iteration,num_sample,alphamax)...
    );

AdaptiveQ_KalmanGain = struct('var001', zeros(2,6,iteration,num_sample,alphamax),...
    'var01', zeros(2,6,iteration,num_sample,alphamax),...
    'var1', zeros(2,6,iteration,num_sample,alphamax),...
    'var10', zeros(2,6,iteration,num_sample,alphamax),...
    'var100', zeros(2,6,iteration,num_sample,alphamax)...
    );

for a = 1:9
    alpha = a/1000000;
    for iter = 1:iteration
        for num = 1:num_sample
            exactPos = [num-1;num-1];
            switch num
                case 1
                    AdaptiveQ_est_state.var001(:,iter,num,a) = [0;0];
                    AdaptiveQ_est_covariance.var001(:,:,iter,num,a) = P.var001;
                    velocity_var001 = [0;0];

                    AdaptiveQ_est_state.var01(:,iter,num,a) = [0;0];
                    AdaptiveQ_est_covariance.var01(:,:,iter,num,a) = P.var01;
                    velocity_var01 = [0;0];

                    AdaptiveQ_est_state.var1(:,iter,num,a) = [0;0];
                    AdaptiveQ_est_covariance.var1(:,:,iter,num,a) = P.var1;
                    velocity_var1 = [0;0];

                    AdaptiveQ_est_state.var10(:,iter,num,a) = [0;0];
                    AdaptiveQ_est_covariance.var10(:,:,iter,num,a) = P.var10;
                    velocity_var10 = [0;0];

                    AdaptiveQ_est_state.var100(:,iter,num,a) = [0;0];
                    AdaptiveQ_est_covariance.var100(:,:,iter,num,a) = P.var100;
                    velocity_var100 = [0;0];
                case 2
                    AdaptiveQ_est_covariance.var001(:,:,iter,num,a) = AdaptiveQ_est_covariance.var001(:,:,iter,num-1,a);
                    AdaptiveQ_est_covariance.var01(:,:,iter,num,a) = AdaptiveQ_est_covariance.var01(:,:,iter,num-1,a);
                    AdaptiveQ_est_covariance.var1(:,:,iter,num,a) = AdaptiveQ_est_covariance.var1(:,:,iter,num-1,a);
                    AdaptiveQ_est_covariance.var10(:,:,iter,num,a) = AdaptiveQ_est_covariance.var10(:,:,iter,num-1,a);
                    AdaptiveQ_est_covariance.var100(:,:,iter,num,a) = AdaptiveQ_est_covariance.var100(:,:,iter,num-1,a);

                    AdaptiveQ_est_state.var001(:,iter,num,a) =LSE.var001(:,iter,num);
                    AdaptiveQ_est_state.var01(:,iter,num,a) =  LSE.var01(:,iter,num);
                    AdaptiveQ_est_state.var1(:,iter,num,a) =    LSE.var1(:,iter,num);
                    AdaptiveQ_est_state.var10(:,iter,num,a) =  LSE.var10(:,iter,num);
                    AdaptiveQ_est_state.var100(:,iter,num,a) =LSE.var100(:,iter,num);
                case 3
                    AdaptiveQ_est_covariance.var001(:,:,iter,num,a) = AdaptiveQ_est_covariance.var001(:,:,iter,num-1,a);
                    AdaptiveQ_est_covariance.var01(:,:,iter,num,a) = AdaptiveQ_est_covariance.var01(:,:,iter,num-1,a);
                    AdaptiveQ_est_covariance.var1(:,:,iter,num,a) = AdaptiveQ_est_covariance.var1(:,:,iter,num-1,a);
                    AdaptiveQ_est_covariance.var10(:,:,iter,num,a) = AdaptiveQ_est_covariance.var10(:,:,iter,num-1,a);
                    AdaptiveQ_est_covariance.var100(:,:,iter,num,a) = AdaptiveQ_est_covariance.var100(:,:,iter,num-1,a);

                    AdaptiveQ_est_state.var001(:,iter,num,a) =LSE.var001(:,iter,num);
                    AdaptiveQ_est_state.var01(:,iter,num,a) =  LSE.var01(:,iter,num);
                    AdaptiveQ_est_state.var1(:,iter,num,a) =    LSE.var1(:,iter,num);
                    AdaptiveQ_est_state.var10(:,iter,num,a) =  LSE.var10(:,iter,num);
                    AdaptiveQ_est_state.var100(:,iter,num,a) =LSE.var100(:,iter,num);

                    velocity_var001 = (AdaptiveQ_est_state.var001(:,iter,num,a) - AdaptiveQ_est_state.var001(:,iter,num-1,a))./dt;
                    velocity_var01 = (AdaptiveQ_est_state.var01(:,iter,num,a) - AdaptiveQ_est_state.var01(:,iter,num-1,a))./dt;
                    velocity_var1 = (AdaptiveQ_est_state.var1(:,iter,num,a) - AdaptiveQ_est_state.var1(:,iter,num-1,a))./dt;
                    velocity_var10 = (AdaptiveQ_est_state.var10(:,iter,num,a) - AdaptiveQ_est_state.var10(:,iter,num-1,a))./dt;
                    velocity_var100 = (AdaptiveQ_est_state.var100(:,iter,num,a) - AdaptiveQ_est_state.var100(:,iter,num-1,a))./dt;
                otherwise
                    [est_state_var001, est_covariance_var001, kalman_gain_001] =...
                        kalmanFilter(AdaptiveQ_est_state.var001(:,iter,num-1,a),AdaptiveQ_est_covariance.var001(:,:,iter,num-1,a),velocity_var001,Q.var001,Rmean.var001(:,:,1,num),Z.var001(:,1,iter,num),meanSysnoise.var001);
                    [est_state_var01, est_covariance_var01, kalman_gain_01] =...
                        kalmanFilter(AdaptiveQ_est_state.var01(:,iter,num-1,a),AdaptiveQ_est_covariance.var01(:,:,iter,num-1,a),velocity_var01,Q.var01,Rmean.var01(:,:,1,num),Z.var01(:,1,iter,num),meanSysnoise.var01);
                    [est_state_var1, est_covariance_var1, kalman_gain_1] =...
                        kalmanFilter(AdaptiveQ_est_state.var1(:,iter,num-1,a),AdaptiveQ_est_covariance.var1(:,:,iter,num-1,a),velocity_var1,Q.var1,Rmean.var1(:,:,1,num),Z.var1(:,1,iter,num),meanSysnoise.var1);
                    [est_state_var10, est_covariance_var10, kalman_gain_10] =...
                        kalmanFilter(AdaptiveQ_est_state.var10(:,iter,num-1,a),AdaptiveQ_est_covariance.var10(:,:,iter,num-1,a),velocity_var10,Q.var10,Rmean.var10(:,:,1,num),Z.var10(:,1,iter,num),meanSysnoise.var10);
                    [est_state_var100, est_covariance_var100, kalman_gain_100] =...
                        kalmanFilter(AdaptiveQ_est_state.var100(:,iter,num-1,a),AdaptiveQ_est_covariance.var100(:,:,iter,num-1,a),velocity_var100,Q.var100,Rmean.var100(:,:,1,num),Z.var100(:,1,iter,num),meanSysnoise.var100);

                    AdaptiveQ_est_state.var001(:,iter,num,a) = est_state_var001;
                    AdaptiveQ_est_state.var01(:,iter,num,a) = est_state_var01;
                    AdaptiveQ_est_state.var1(:,iter,num,a) = est_state_var1;
                    AdaptiveQ_est_state.var10(:,iter,num,a) = est_state_var10;
                    AdaptiveQ_est_state.var100(:,iter,num,a) = est_state_var100;

                    AdaptiveQ_est_covariance.var001(:,:,iter,num,a) = est_covariance_var001;
                    AdaptiveQ_est_covariance.var01(:,:,iter,num,a) = est_covariance_var01;
                    AdaptiveQ_est_covariance.var1(:,:,iter,num,a) = est_covariance_var1;
                    AdaptiveQ_est_covariance.var10(:,:,iter,num,a) = est_covariance_var10;
                    AdaptiveQ_est_covariance.var100(:,:,iter,num,a) = est_covariance_var100;

                    AdaptiveQ_KalmanGain.var001(:,:,iter,num,a) = kalman_gain_001;
                    AdaptiveQ_KalmanGain.var01(:,:,iter,num,a) = kalman_gain_01;
                    AdaptiveQ_KalmanGain.var1(:,:,iter,num,a) = kalman_gain_1;
                    AdaptiveQ_KalmanGain.var10(:,:,iter,num,a) = kalman_gain_10;
                    AdaptiveQ_KalmanGain.var100(:,:,iter,num,a) = kalman_gain_100;

                    velocity_var001 = (AdaptiveQ_est_state.var001(:,iter,num,a) - AdaptiveQ_est_state.var001(:,iter,num-1,a))./dt;
                    velocity_var01 = (AdaptiveQ_est_state.var01(:,iter,num,a) - AdaptiveQ_est_state.var01(:,iter,num-1,a))./dt;
                    velocity_var1 = (AdaptiveQ_est_state.var1(:,iter,num,a) - AdaptiveQ_est_state.var1(:,iter,num-1,a))./dt;
                    velocity_var10 = (AdaptiveQ_est_state.var10(:,iter,num,a) - AdaptiveQ_est_state.var10(:,iter,num-1,a))./dt;
                    velocity_var100 = (AdaptiveQ_est_state.var100(:,iter,num,a) - AdaptiveQ_est_state.var100(:,iter,num-1,a))./dt;

                    Q.var001 = Q.var001*exp(-alpha*(num-3));
                    Q.var01 = Q.var01*exp(-alpha*(num-3));
                    Q.var1 = Q.var1*exp(-alpha*(num-3));
                    Q.var10 = Q.var10*exp(-alpha*(num-3));
                    Q.var100 = Q.var100*exp(-alpha*(num-3));
            end
        end
    end
end

save('AdaptiveQ_est_state.mat','AdaptiveQ_est_state');
% save('est_covariance.mat','est_covariance');
% save('KalmanGain.mat','KalmanGain');

% n_variance = [1e-2; 1e-1; 1e0; 1e1; 1e2];
% a = mean(AdaptiveQ_est_covariance.var10,[3.);
% for i = 1:num_sample
%     buf_Q(i,1) = trace(a(:,:,1,i));
% end
% figure;
% stem((1:num_sample),buf_Q);
% title("tr(P) KFQ")
% xlabel("step")
% ylabel("trace(P_k)")

end