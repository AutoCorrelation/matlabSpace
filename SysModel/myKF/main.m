clear
close all
clc

iteration = 1e4;
number_of_samples = 11;
noise_variance = [0.01; 0.1; 1; 10; 100];
dist_from_anchor_to_pos = zeros(4,number_of_samples,length(noise_variance),iteration);
pos_ToA = zeros(2,number_of_samples,length(noise_variance),iteration);
err_ToA = zeros(1,number_of_samples,length(noise_variance),iteration);
P0 = zeros(2,2,length(noise_variance),1);
Q = zeros(2,2,length(noise_variance),1);
R = zeros(6,6,number_of_samples,length(noise_variance),iteration);
e_k = zeros(2,1,length(noise_variance),iteration); % Pre-allocate e_k
w_k = zeros(2,1,length(noise_variance),iteration); % Pre-allocate w_k

d1 = 10;
d2 = d1;
H = [...
    0, -2*d2
    2*d1, -2*d2
    2*d1, 0
    2*d1, 0
    2*d1, 2*d2
    0, 2*d2];

for noise = 1:length(noise_variance)
    for iter=1:iteration
        for num = 1:number_of_samples
            % Generate data
            real_pos = [num-1;num-1];
            D = anchorMeasure(real_pos, noise_variance(noise));
            dist_from_anchor_to_pos(:,num,noise,iter) = D;
            Z = [D(1,1)^2 - D(2,1)^2 - d2^2
                D(1,1)^2 - D(3,1)^2 + d1^2 - d2^2
                D(1,1)^2 - D(4,1)^2 + d1^2
                D(2,1)^2 - D(3,1)^2 + d1^2
                D(2,1)^2 - D(4,1)^2 + d1^2 + d2^2
                D(3,1)^2 - D(4,1)^2 + d2^2];
            
            R(:,:,num,noise,iter) = ...
                [4*noise_variance(noise,1)*(D(1,1)^2+D(2,1)^2) 4*noise_variance(noise,1)*(D(1,1)^2) 4*noise_variance(noise,1)*(D(1,1)^2) -4*noise_variance(noise,1)*(D(2,1)^2) -4*noise_variance(noise,1)*(D(2,1)^2) 0;...
                4*noise_variance(noise,1)*(D(1,1)^2) 4*noise_variance(noise,1)*(D(1,1)^2+D(3,1)^2) 4*noise_variance(noise,1)*(D(1,1)^2) 4*noise_variance(noise,1)*(D(3,1)^2) 0 -4*noise_variance(noise,1)*(D(3,1)^2);...
                4*noise_variance(noise,1)*(D(1,1)^2) 4*noise_variance(noise,1)*(D(1,1)^2) 4*noise_variance(noise,1)*(D(1,1)^2+D(4,1)^2) 0 4*noise_variance(noise,1)*(D(4,1)^2) 4*noise_variance(noise,1)*(D(4,1)^2);...
                -4*noise_variance(noise,1)*(D(2,1)^2) 4*noise_variance(noise,1)*(D(3,1)^2) 0 4*noise_variance(noise,1)*(D(2,1)^2+D(3,1)^2) 4*noise_variance(noise,1)*(D(2,1)^2) -4*noise_variance(noise,1)*(D(3,1)^2);...
                -4*noise_variance(noise,1)*(D(2,1)^2) 0 4*noise_variance(noise,1)*(D(4,1)^2) 4*noise_variance(noise,1)*(D(2,1)^2) 4*noise_variance(noise,1)*(D(2,1)^2+D(4,1)^2) 4*noise_variance(noise,1)*(D(4,1)^2);...
                0 -4*noise_variance(noise,1)*(D(3,1)^2) 4*noise_variance(noise,1)*(D(4,1)^2) -4*noise_variance(noise,1)*(D(3,1)^2) 4*noise_variance(noise,1)*(D(4,1)^2) 4*noise_variance(noise,1)*(D(3,1)^2+D(4,1)^2)
                ];
            
            % Calculate ToA
            pos_ToA(:,num,noise,iter) = func_ToA(Z);
            err_ToA(1,num,noise,iter) = norm(pos_ToA(:,num,noise,iter) - real_pos);
            
            % save e_k
            % save e_k
            if num == 5
                e_k(:,1,noise,iter) = pos_ToA(:,num,noise,iter) - real_pos;
                vel = pos_ToA(:,num-1,noise,iter) - pos_ToA(:,num-2,noise,iter);
                w_k(:,1,noise,iter) = real_pos - (pos_ToA(:,num-1,noise,iter) + vel);
            end
            
        end
    end
    % calculate P0 Q
    t1 = squeeze(e_k(:,1,noise,:)-mean(e_k(:,1,noise,:),4));
    t2 = squeeze(w_k(:,1,noise,:)-mean(w_k(:,1,noise,:),4));
    P0(:,:,noise,1) = t1*t1'/iteration;
    Q(:,:,noise,1) = t2*t2'/iteration;
end
R = squeeze(sum(R,5)/iteration);
% min_R_value = -1e3; % 최소 허용 값
% max_R_value = 1e3; % 최대 허용 값
% R(R > max_R_value) = max_R_value;
% R(R < min_R_value) = min_R_value;

w_k_bias = mean(w_k(:,1,:,:),4);
saveArrayToCSV(w_k_bias, 'w_k_bias.csv');
saveArrayToCSV(P0, 'P0.csv');
saveArrayToCSV(Q, 'Q.csv');
saveArrayToCSV(R, 'R.csv');

Qbuf = Q;
% gamma = [0.132 0.126 0.126 0.124 0.072]

%% Apply Kalman Filter
Q3 = zeros(2,2,length(noise_variance),1);
err_KF = zeros(1,number_of_samples,length(noise_variance),iteration);
estimated_pos = zeros(2,number_of_samples,length(noise_variance),iteration);
estimated_covariance = zeros(2,2,number_of_samples,length(noise_variance),iteration);
w2_k = zeros(2,number_of_samples,length(noise_variance),iteration);
for noise = 1:length(noise_variance)
    for iter = 1:iteration
        Q = Qbuf;
        for num = 1:number_of_samples
            real_pos = [num-1;num-1];
            if num < 4
                estimated_pos(:,num,noise,iter) = pos_ToA(:,num,noise,iter);
                estimated_covariance(:,:,num,noise,iter) = P0(:,:,noise,1);
            else
                previous_state = estimated_pos(:,num-1,noise,iter);
                previous_covariance = estimated_covariance(:,:,num-1,noise,iter);
                previous_vel = estimated_pos(:,num-1,noise,iter) - estimated_pos(:,num-2,noise,iter);
                Z = [dist_from_anchor_to_pos(1,num,noise,iter)^2 - dist_from_anchor_to_pos(2,num,noise,iter)^2 - d2^2
                    dist_from_anchor_to_pos(1,num,noise,iter)^2 - dist_from_anchor_to_pos(3,num,noise,iter)^2 + d1^2 - d2^2
                    dist_from_anchor_to_pos(1,num,noise,iter)^2 - dist_from_anchor_to_pos(4,num,noise,iter)^2 + d1^2
                    dist_from_anchor_to_pos(2,num,noise,iter)^2 - dist_from_anchor_to_pos(3,num,noise,iter)^2 + d1^2
                    dist_from_anchor_to_pos(2,num,noise,iter)^2 - dist_from_anchor_to_pos(4,num,noise,iter)^2 + d1^2 + d2^2
                    dist_from_anchor_to_pos(3,num,noise,iter)^2 - dist_from_anchor_to_pos(4,num,noise,iter)^2 + d2^2];
                [x_hat, P, Q_adaptive] = func_KF(previous_state, previous_covariance, previous_vel, w_k_bias(:,1,noise), Q(:,:,noise,1), diag(diag(R(:,:,num,noise))), Z);
                estimated_pos(:,num,noise,iter) = x_hat;
                estimated_covariance(:,:,num,noise,iter) = P;
                
                w2_k(:,num,noise,iter) = real_pos - x_hat;
                % 현재 주석처리된 코드를 개선
                % Q = Q * exp(-gamma(noise)*(num-3));
                % Q = gamma(noise)*Q;
                Q(:,:,noise,1) = Q_adaptive;
                
            end
            err_KF(1,num,noise,iter) = norm(estimated_pos(:,num,noise,iter) - real_pos);
        end
    end
    t3 = squeeze(mean(w2_k(:,:,noise,:)-mean(w2_k(:,:,noise,:),4),2));
    Q3(:,:,noise,1) = t3*t3'/(iteration*(number_of_samples-3));
end

saveArrayToCSV(Q3, 'Q3.csv');

%% plot
semilogx(noise_variance,squeeze(mean(mean(err_ToA,2),4)),'DisplayName','ToA');
hold on
grid on
semilogx(noise_variance,squeeze(mean(mean(err_KF,2),4)),'DisplayName','KF');

figure;
bivariate_hist(w2_k(1,5,5,:),w2_k(2,5,5,:),1);
figure;
buf = zeros(number_of_samples,1);
for i = 1:number_of_samples
    buf(i,1) = trace(estimated_covariance(:,:,i,3,1));
end
plot(1:number_of_samples,buf);