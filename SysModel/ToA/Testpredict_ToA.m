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
ErrLoc001 = zeros(iteration,samples);

meas_x01 = zeros(iteration,samples);
meas_y01 = zeros(iteration,samples);
ErrLoc01= zeros(iteration,samples);

meas_x1 = zeros(iteration,samples);
meas_y1 = zeros(iteration,samples);
ErrLoc1 = zeros(iteration,samples);

meas_x10 = zeros(iteration,samples);
meas_y10 = zeros(iteration,samples);
ErrLoc10 = zeros(iteration,samples);

meas_x100 = zeros(iteration,samples);
meas_y100 = zeros(iteration,samples);
ErrLoc100 = zeros(iteration,samples);

exactPosX = load("exactPosX.txt");
exactPosY = load("exactPosY.txt");

matrix_eeT001 = zeros(2,2);
matrix_eeT01 = zeros(2,2);
matrix_eeT1 = zeros(2,2);
matrix_eeT10 = zeros(2,2);
matrix_eeT100 = zeros(2,2);

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
        
        if num==1
            vec_eeT001(:,iter) = v_ErrLoc001;
            vec_eeT01(:,iter) = v_ErrLoc01;
            vec_eeT1(:,iter) = v_ErrLoc1;
            vec_eeT10(:,iter) = v_ErrLoc10;
            vec_eeT100(:,iter) = v_ErrLoc100;
        end
        matrix_eeT001 = matrix_eeT001 + v_ErrLoc001*v_ErrLoc001';
        matrix_eeT01 = matrix_eeT01 + v_ErrLoc01*v_ErrLoc01';
        matrix_eeT1 = matrix_eeT1 + v_ErrLoc1*v_ErrLoc1';
        matrix_eeT10 = matrix_eeT10 + v_ErrLoc10*v_ErrLoc10';
        matrix_eeT100 = matrix_eeT100 + v_ErrLoc100*v_ErrLoc100';

        if num>3
            vec_vel001 = [meas_x001(:,num)-meas_x001(:,num-1); meas_y001(:,num)-meas_y001(:,num-1)]./dt;
            vec_vel01 = [meas_x01(:,num)-meas_x01(:,num-1); meas_y01(:,num)-meas_y01(:,num-1)]./dt;
            vec_vel1 = [meas_x1(:,num)-meas_x1(:,num-1); meas_y1(:,num)-meas_y1(:,num-1)]./dt;
            vec_vel10 = [meas_x10(:,num)-meas_x10(:,num-1); meas_y10(:,num)-meas_y10(:,num-1)]./dt;
            vec_vel100 = [meas_x100(:,num)-meas_x100(:,num-1); meas_y100(:,num)-meas_y100(:,num-1)]./dt;
        end
        vec_prev_wk001 = [exactPosX()]
    end
end

meanErr = [mean(ErrLoc001,"all");mean(ErrLoc01,"all");mean(ErrLoc1,"all");mean(ErrLoc10,"all");mean(ErrLoc100,"all")];
matrix_eeT001 = matrix_eeT001./iteration;
matrix_eeT01 = matrix_eeT01./iteration;
matrix_eeT1 = matrix_eeT1./iteration;
matrix_eeT10 = matrix_eeT10./iteration;
matrix_eeT100 = matrix_eeT100./iteration;

P0 = struct(...
    'var001',matrix_eeT001 - mean(vec_eeT001,2)*mean(vec_eeT001,2)',...
    'var01',matrix_eeT01 - mean(vec_eeT01,2)*mean(vec_eeT01,2)',...
    'var1',matrix_eeT1 - mean(vec_eeT1,2)*mean(vec_eeT1,2)',...
    'var10',matrix_eeT10 - mean(vec_eeT10,2)*mean(vec_eeT10,2)',...
    'var100',matrix_eeT100 - mean(vec_eeT100,2)*mean(vec_eeT100,2)');

    

figure(1)
semilogx(m_variance,meanErr);
title("ToA err according to measurement noise");
xlabel("variance");
ylabel("err");
legend("ToA");
grid on



