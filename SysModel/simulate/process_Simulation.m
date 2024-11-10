function process_Simulation()
format long e;
clear all;

dt = 0.1;
iteration = 1e4;
n_variance = [1e-2; 1e-1; 1e0; 1e1; 1e2];
load("LSE.mat");

F = [1 0;0 1];

Q = struct(...
    'var001', zeros(2,2),...
    'var01', zeros(2,2),...
    'var1', zeros(2,2),...
    'var10', zeros(2,2),...
    'var100', zeros(2,2)...
    );

vec_processNoise = struct(...
    'var001', zeros(2,iteration),...
    'var01', zeros(2,iteration),...
    'var1', zeros(2,iteration),...
    'var10', zeros(2,iteration),...
    'var100', zeros(2,iteration)...
    );

for iter = 1:iteration
    k_state = [3;3];
    k_velocity = [10;10];

    prev_state001 = LSE.var001(:,iter,3);
    prev_velocity001 = (LSE.var001(:,iter,3)-LSE.var001(:,iter,2))./dt;
    vec_processNoise.var001(:,iter) = k_state - F*prev_state001 - prev_velocity001.*dt;
    wwT001(:,:,iter) = vec_processNoise.var001(:,iter)*vec_processNoise.var001(:,iter)';

    prev_state01 = LSE.var01(:,iter,3);
    prev_velocity01 = (LSE.var01(:,iter,3)-LSE.var01(:,iter,2))./dt;
    vec_processNoise.var01(:,iter) = k_state - F*prev_state01 - prev_velocity01.*dt;
    wwT01(:,:,iter) = vec_processNoise.var01(:,iter)*vec_processNoise.var01(:,iter)';

    prev_state1 = LSE.var1(:,iter,3);
    prev_velocity1 = (LSE.var1(:,iter,3)-LSE.var1(:,iter,2))./dt;
    vec_processNoise.var1(:,iter) = k_state - F*prev_state1 - prev_velocity1.*dt;
    wwT1(:,:,iter) = vec_processNoise.var1(:,iter)*vec_processNoise.var1(:,iter)';

    prev_state10 = LSE.var10(:,iter,3);
    prev_velocity10 = (LSE.var10(:,iter,3)-LSE.var10(:,iter,2))./dt;
    vec_processNoise.var10(:,iter) = k_state - F*prev_state10 - prev_velocity10.*dt;
    wwT10(:,:,iter) = vec_processNoise.var10(:,iter)*vec_processNoise.var10(:,iter)';

    prev_state100 = LSE.var100(:,iter,3);
    prev_velocity100 = (LSE.var100(:,iter,3)-LSE.var100(:,iter,2))./dt;
    vec_processNoise.var100(:,iter) = k_state - F*prev_state100 - prev_velocity100.*dt;
    wwT100(:,:,iter) = vec_processNoise.var100(:,iter)*vec_processNoise.var100(:,iter)';

    eeT001(:,:,iter) = LSE.var001(:,iter,1)*LSE.var001(:,iter,1)';
    eeT01(:,:,iter) = LSE.var01(:,iter,1)*LSE.var01(:,iter,1)';
    eeT1(:,:,iter) = LSE.var1(:,iter,1)*LSE.var1(:,iter,1)';
    eeT10(:,:,iter) = LSE.var10(:,iter,1)*LSE.var10(:,iter,1)';
    eeT100(:,:,iter) = LSE.var100(:,iter,1)*LSE.var100(:,iter,1)';

end

Q = struct(...
    'var001', diag(eig(mean(wwT001,3) - mean(vec_processNoise.var001,2)*mean(vec_processNoise.var001,2)')),...
    'var01', diag(eig(mean(wwT01,3) - mean(vec_processNoise.var01,2)*mean(vec_processNoise.var01,2)')),...
    'var1', diag(eig(mean(wwT1,3) - mean(vec_processNoise.var1,2)*mean(vec_processNoise.var1,2)')),...
    'var10', diag(eig(mean(wwT10,3) - mean(vec_processNoise.var10,2)*mean(vec_processNoise.var10,2)')),...
    'var100', diag(eig(mean(wwT100,3) - mean(vec_processNoise.var100,2)*mean(vec_processNoise.var100,2)'))...
    );

save("Q.mat","Q");

P = struct(...
    'var001', diag(eig(mean(eeT001,3)-mean(LSE.var001(:,:,1),2)*mean(LSE.var001(:,:,1),2)')),...
    'var01', diag(eig(mean(eeT01,3)-mean(LSE.var01(:,:,1),2)*mean(LSE.var01(:,:,1),2)')),...
    'var1', diag(eig(mean(eeT1,3)-mean(LSE.var1(:,:,1),2)*mean(LSE.var1(:,:,1),2)')),...
    'var10', diag(eig(mean(eeT10,3)-mean(LSE.var10(:,:,1),2)*mean(LSE.var10(:,:,1),2)')),...
    'var100', diag(eig(mean(eeT100,3)-mean(LSE.var100(:,:,1),2)*mean(LSE.var100(:,:,1),2)'))...
    );

save("P.mat","P");

scatter(vec_processNoise.var001(1,:),vec_processNoise.var001(2,:));
end
