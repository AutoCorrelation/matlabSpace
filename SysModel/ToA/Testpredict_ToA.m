clear
close all
clc

AnchorMax1 = 10;
AnchorMax2 = 10;
Anchor = struct('a1',[0;AnchorMax1],'a2',[0;0],'a3',[AnchorMax2;0],'a4',[AnchorMax1;AnchorMax2]);

m_variance=[0.01; 0.1; 1; 10; 100];
iteration=1e3;
samples=11;

A = eye(2,2);
dt = 0.1;

getNewMeasrue = false;
if(getNewMeasrue)
    Measurement(iteration,samples,Anchor);
else
    disp("Use previously recorded measurements");
end

measurement1_001 = load("measurements_Anchor1_001.txt");
measurement2_001 = load("measurements_Anchor2_001.txt");
measurement3_001 = load("measurements_Anchor3_001.txt");
measurement4_001 = load("measurements_Anchor4_001.txt");

measurement1_01 = load("measurements_Anchor1_01.txt");
measurement2_01 = load("measurements_Anchor2_01.txt");
measurement3_01 = load("measurements_Anchor3_01.txt");
measurement4_01 = load("measurements_Anchor4_01.txt");

measurement1_1 = load("measurements_Anchor1_1.txt");
measurement2_1 = load("measurements_Anchor2_1.txt");
measurement3_1 = load("measurements_Anchor3_1.txt");
measurement4_1 = load("measurements_Anchor4_1.txt");

measurement1_10 = load("measurements_Anchor1_10.txt");
measurement2_10 = load("measurements_Anchor2_10.txt");
measurement3_10 = load("measurements_Anchor3_10.txt");
measurement4_10 = load("measurements_Anchor4_10.txt");

measurement1_100 = load("measurements_Anchor1_100.txt");
measurement2_100 = load("measurements_Anchor2_100.txt");
measurement3_100 = load("measurements_Anchor3_100.txt");
measurement4_100 = load("measurements_Anchor4_100.txt");

measurements_001 = struct('a1',measurement1_001,'a2',measurement2_001,'a3',measurement3_001,'a4',measurement4_001);
measurements_01 = struct('a1',measurement1_01,'a2',measurement2_01,'a3',measurement3_01,'a4',measurement4_01);
measurements_1 = struct('a1',measurement1_1,'a2',measurement2_1,'a3',measurement3_1,'a4',measurement4_1);
measurements_10 = struct('a1',measurement1_10,'a2',measurement2_10,'a3',measurement3_10,'a4',measurement4_10);
measurements_100 = struct('a1',measurement1_100,'a2',measurement2_100,'a3',measurement3_100,'a4',measurement4_100);

meas_x001 = zeros(iteration,samples);
meas_y001 = zeros(iteration,samples);
predic_x001 = zeros(iteration,samples-1);
predic_y001 = zeros(iteration,samples-1);
ErrLoc001 = zeros(iteration,samples);

meas_x01 = zeros(iteration,samples);
meas_y01 = zeros(iteration,samples);
predic_x01 = zeros(iteration,samples-1);
predic_y01 = zeros(iteration,samples-1);
ErrLoc01= zeros(iteration,samples);

meas_x1 = zeros(iteration,samples);
meas_y1 = zeros(iteration,samples);
predic_x1 = zeros(iteration,samples-1);
predic_y1 = zeros(iteration,samples-1);
ErrLoc1 = zeros(iteration,samples);

meas_x10 = zeros(iteration,samples);
meas_y10 = zeros(iteration,samples);
predic_x10 = zeros(iteration,samples-1);
predic_y10 = zeros(iteration,samples-1);
ErrLoc10 = zeros(iteration,samples);

meas_x100 = zeros(iteration,samples);
meas_y100 = zeros(iteration,samples);
predic_x100 = zeros(iteration,samples-1);
predic_y100 = zeros(iteration,samples-1);
ErrLoc100 = zeros(iteration,samples);

exactPosX = load("exactPosX.txt");
exactPosY = load("exactPosY.txt");

vec_0err001 = zeros(2,iteration);
vec_0err01 = zeros(2,iteration);
vec_0err1 = zeros(2,iteration);
vec_0err10 = zeros(2,iteration);
vec_0err100 = zeros(2,iteration);

vec_3w001 = zeros(2,iteration);
vec_3w01 = zeros(2,iteration);
vec_3w1 = zeros(2,iteration);
vec_3w10 = zeros(2,iteration);
vec_3w100 = zeros(2,iteration);

matrix_eeT001 = zeros(2,2);
matrix_eeT01 = zeros(2,2);
matrix_eeT1 = zeros(2,2);
matrix_eeT10 = zeros(2,2);
matrix_eeT100 = zeros(2,2);

matrix_wwT001 = zeros(2,2);
matrix_wwT01 = zeros(2,2);
matrix_wwT1 = zeros(2,2);
matrix_wwT10 = zeros(2,2);
matrix_wwT100 = zeros(2,2);

for iter=1:iteration
    for num=1:samples
        [meas_x001(iter,num),meas_y001(iter,num),v_ErrLoc001] = prev_ToA(Anchor, measurements_001,iter,num);
        [meas_x01(iter,num),meas_y01(iter,num),v_ErrLoc01] = prev_ToA(Anchor, measurements_01,iter,num);
        [meas_x1(iter,num),meas_y1(iter,num),v_ErrLoc1] = prev_ToA(Anchor, measurements_1,iter,num);
        [meas_x10(iter,num),meas_y10(iter,num),v_ErrLoc10] = prev_ToA(Anchor, measurements_10,iter,num);
        [meas_x100(iter,num),meas_y100(iter,num),v_ErrLoc100] = prev_ToA(Anchor, measurements_100,iter,num);

        ErrLoc001(iter,num) = norm(v_ErrLoc001);
        ErrLoc01(iter,num) = norm(v_ErrLoc01);
        ErrLoc1(iter,num) = norm(v_ErrLoc1);
        ErrLoc10(iter,num) = norm(v_ErrLoc10);
        ErrLoc100(iter,num) = norm(v_ErrLoc100);

        switch num
            case 1
                vec_0err001(:,iter) = v_ErrLoc001;
                vec_0err01(:,iter) = v_ErrLoc01;
                vec_0err1(:,iter) = v_ErrLoc1;
                vec_0err10(:,iter) = v_ErrLoc10;
                vec_0err100(:,iter) = v_ErrLoc100;

                matrix_eeT001 = matrix_eeT001 + v_ErrLoc001*v_ErrLoc001';
                matrix_eeT01 = matrix_eeT01 + v_ErrLoc01*v_ErrLoc01';
                matrix_eeT1 = matrix_eeT1 + v_ErrLoc1*v_ErrLoc1';
                matrix_eeT10 = matrix_eeT10 + v_ErrLoc10*v_ErrLoc10';
                matrix_eeT100 = matrix_eeT100 + v_ErrLoc100*v_ErrLoc100';
            case 2
                vec_predict001 = [meas_x001(iter,num);meas_y001(iter,num)];
                vec_predict01 = [meas_x01(iter,num);meas_y01(iter,num)];
                vec_predict1 = [meas_x1(iter,num);meas_y1(iter,num)];
                vec_predict10 = [meas_x10(iter,num);meas_y10(iter,num)];
                vec_predict100 = [meas_x100(iter,num);meas_y100(iter,num)];

                predic_x001(iter,num-1) = vec_predict001(1);
                predic_x01(iter,num-1) = vec_predict01(1);
                predic_x1(iter,num-1) = vec_predict1(1);
                predic_x10(iter,num-1) = vec_predict10(1);
                predic_x100(iter,num-1) = vec_predict100(1);

                predic_y001(iter,num-1) = vec_predict001(2);
                predic_y01(iter,num-1) = vec_predict01(2);
                predic_y1(iter,num-1) = vec_predict1(2);
                predic_y10(iter,num-1) = vec_predict10(2);
                predic_y100(iter,num-1) = vec_predict100(2);
            case 3
                vec_velocity001 = [vec_predict001(1)-meas_x001(iter,num-2);vec_predict001(2)-meas_y001(iter,num-2)]/dt;
                vec_velocity01 = [vec_predict01(1)-meas_x01(iter,num-2);vec_predict01(2)-meas_y01(iter,num-2)]/dt;
                vec_velocity1 = [vec_predict1(1)-meas_x1(iter,num-2);vec_predict1(2)-meas_y1(iter,num-2)]/dt;
                vec_velocity10 = [vec_predict10(1)-meas_x10(iter,num-2);vec_predict10(2)-meas_y10(iter,num-2)]/dt;
                vec_velocity100 = [vec_predict100(1)-meas_x100(iter,num-2);vec_predict100(2)-meas_y100(iter,num-2)]/dt;

                vec_predict001 = A*vec_predict001 + vec_velocity001*dt;
                vec_predict01 = A*vec_predict01 + vec_velocity01*dt;
                vec_predict1 = A*vec_predict1 + vec_velocity1*dt;
                vec_predict10 = A*vec_predict10 + vec_velocity10*dt;
                vec_predict100 = A*vec_predict100 + vec_velocity100*dt;

                vec_3w001(:,iter) = ([exactPosX(iter,num);exactPosY(iter,num)] - vec_predict001);
                vec_3w01(:,iter) = ([exactPosX(iter,num);exactPosY(iter,num)] - vec_predict01);
                vec_3w1(:,iter) = ([exactPosX(iter,num);exactPosY(iter,num)] - vec_predict1);
                vec_3w10(:,iter) = ([exactPosX(iter,num);exactPosY(iter,num)] - vec_predict10);
                vec_3w100(:,iter) = ([exactPosX(iter,num);exactPosY(iter,num)] - vec_predict100);
                matrix_wwT001 = matrix_wwT001 + vec_3w001(:,iter)*vec_3w001(:,iter)';
                matrix_wwT01 = matrix_wwT01 + vec_3w01(:,iter)*vec_3w01(:,iter)';
                matrix_wwT1 = matrix_wwT1 + vec_3w1(:,iter)*vec_3w1(:,iter)';
                matrix_wwT10 = matrix_wwT10 + vec_3w10(:,iter)*vec_3w10(:,iter)';
                matrix_wwT100 = matrix_wwT100 + vec_3w100(:,iter)*vec_3w100(:,iter)';
        end
    end
end

meanErr = [mean(ErrLoc001,"all");mean(ErrLoc01,"all");mean(ErrLoc1,"all");mean(ErrLoc10,"all");mean(ErrLoc100,"all")];
matrix_eeT001 = matrix_eeT001./iteration;
matrix_eeT01 = matrix_eeT01./iteration;
matrix_eeT1 = matrix_eeT1./iteration;
matrix_eeT10 = matrix_eeT10./iteration;
matrix_eeT100 = matrix_eeT100./iteration;

matrix_wwT001 = matrix_wwT001./iteration;
matrix_wwT01 = matrix_wwT01./iteration;
matrix_wwT1 = matrix_wwT1./iteration;
matrix_wwT10 = matrix_wwT10./iteration;
matrix_wwT100 = matrix_wwT100./iteration;

P0 = struct(...
    'var001',matrix_eeT001 - mean(vec_0err001,2)*mean(vec_0err001,2)',...
    'var01',matrix_eeT01 - mean(vec_0err01,2)*mean(vec_0err01,2)',...
    'var1',matrix_eeT1 - mean(vec_0err1,2)*mean(vec_0err1,2)',...
    'var10',matrix_eeT10 - mean(vec_0err10,2)*mean(vec_0err10,2)',...
    'var100',matrix_eeT100 - mean(vec_0err100,2)*mean(vec_0err100,2)');

Q3 = struct(...
    'var001',matrix_wwT001 - mean(vec_3w001,2)*mean(vec_3w001,2)',...
    'var01',matrix_wwT01 - mean(vec_3w01,2)*mean(vec_3w01,2)',...
    'var1',matrix_wwT1 - mean(vec_3w1,2)*mean(vec_3w1,2)',...
    'var10',matrix_wwT10 - mean(vec_3w10,2)*mean(vec_3w10,2)',...
    'var100',matrix_wwT100 - mean(vec_3w100,2)*mean(vec_3w100,2)');

save('P0.mat','P0');
save('Q3.mat','Q3');

figure(1)
semilogx(m_variance,meanErr);
title("ToA err according to measurement noise");
xlabel("variance");
ylabel("err");
legend("ToA");
grid on



