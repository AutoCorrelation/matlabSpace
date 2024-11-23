function KFpredict_ToA(iteration)
load("LSE.mat");
load("meanSysnoise.mat");
load("Q.mat");
dt = 0.1;

% iteration = 1e5;
num_sample = 11;
num_alpha = 9;
KFpredict_state = struct('var001', zeros(2,iteration,num_sample,num_alpha),...
    'var01', zeros(2,iteration,num_sample,num_alpha),...
    'var1', zeros(2,iteration,num_sample,num_alpha),...
    'var10', zeros(2,iteration,num_sample,num_alpha),...
    'var100', zeros(2,iteration,num_sample,num_alpha)...
    );


for a = 1:9
    alpha = a/10;
    for iter = 1:iteration
        for num = 1:num_sample
            switch num
                case 1
                    % KFpredict_state.var001(:,iter,num,a) =  LSE.var001(:,iter,num);
                    % KFpredict_state.var01(:,iter,num,a) = LSE.var01(:,iter,num);
                    % KFpredict_state.var1(:,iter,num,a)  = LSE.var1(:,iter,num);
                    % KFpredict_state.var10(:,iter,num,a) = LSE.var10(:,iter,num);
                    % KFpredict_state.var100(:,iter,num,a) =  LSE.var100(:,iter,num);

                    KFpredict_state.var001(:,iter,num,a) = [0;0];
                    KFpredict_state.var01(:,iter,num,a) = [0;0];
                    KFpredict_state.var1(:,iter,num,a)  = [0;0];
                    KFpredict_state.var10(:,iter,num,a) = [0;0];
                    KFpredict_state.var100(:,iter,num,a) =  [0;0];
                otherwise
                    % velocity_var001 = (LSE.var001(:,iter,num) - KFpredict_state.var001(:,iter,num-1,a))./dt;
                    velocity_var001 = (LSE.var001(:,iter,num) - LSE.var001(:,iter,num-1))./dt;
                    prev_est_state_var001 = kalmanFilter_prediction(KFpredict_state.var001(:,iter,num-1,a),velocity_var001,meanSysnoise.var001);
                    KFpredict_state.var001(:,iter,num,a) = lowpassFilter(prev_est_state_var001,LSE.var001(:,iter,num),alpha);

                    % velocity_var01 = (LSE.var01(:,iter,num) - KFpredict_state.var01(:,iter,num-1,a))./dt;
                    velocity_var01 = (LSE.var01(:,iter,num) - LSE.var01(:,iter,num-1))./dt;
                    prev_est_state_var01 = kalmanFilter_prediction(KFpredict_state.var01(:,iter,num-1,a),velocity_var01,meanSysnoise.var01);
                    KFpredict_state.var01(:,iter,num,a) = lowpassFilter(prev_est_state_var01,LSE.var01(:,iter,num),alpha);

                    % velocity_var1 = (LSE.var1(:,iter,num) - KFpredict_state.var1(:,iter,num-1,a))./dt;
                    velocity_var1 = (LSE.var1(:,iter,num) - LSE.var1(:,iter,num-1))./dt;
                    prev_est_state_var1 = kalmanFilter_prediction(KFpredict_state.var1(:,iter,num-1,a),velocity_var1,meanSysnoise.var1);
                    KFpredict_state.var1(:,iter,num,a) = lowpassFilter(prev_est_state_var1,LSE.var1(:,iter,num),alpha);

                    % velocity_var10 = (LSE.var10(:,iter,num) - KFpredict_state.var10(:,iter,num-1,a))./dt;
                    velocity_var10 = (LSE.var10(:,iter,num) - LSE.var10(:,iter,num-1))./dt;
                    prev_est_state_var10 = kalmanFilter_prediction(KFpredict_state.var10(:,iter,num-1,a),velocity_var10,meanSysnoise.var10);
                    KFpredict_state.var10(:,iter,num,a) = lowpassFilter(prev_est_state_var10,LSE.var10(:,iter,num),alpha);

                    % velocity_var100 = (LSE.var100(:,iter,num) - KFpredict_state.var100(:,iter,num-1,a))./dt;
                    velocity_var100 = (LSE.var100(:,iter,num) - LSE.var100(:,iter,num-1))./dt;
                    prev_est_state_var100 = kalmanFilter_prediction(KFpredict_state.var100(:,iter,num-1,a),velocity_var100,meanSysnoise.var100);
                    KFpredict_state.var100(:,iter,num,a) = lowpassFilter(prev_est_state_var100,LSE.var100(:,iter,num),alpha);
            end
        end
    end
end
save("KFpredict_state.mat","KFpredict_state");
end