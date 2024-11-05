function [] = Measurement(iteration,Nsamples,Anchor)
% Measure d1~d4 from Anchor1~4 and save data.
%

% Measurement Noises Matrix
measurementNoise = [0.01,0.1,1,10,100];

% file open
fileID001_1 = fopen('measurements_Anchor1_001.txt','w');
fileID001_2 = fopen('measurements_Anchor2_001.txt','w');
fileID001_3 = fopen('measurements_Anchor3_001.txt','w');
fileID001_4 = fopen('measurements_Anchor4_001.txt','w');

fileID01_1 = fopen('measurements_Anchor1_01.txt','w');
fileID01_2 = fopen('measurements_Anchor2_01.txt','w');
fileID01_3 = fopen('measurements_Anchor3_01.txt','w');
fileID01_4 = fopen('measurements_Anchor4_01.txt','w');

fileID1_1 = fopen('measurements_Anchor1_1.txt','w');
fileID1_2 = fopen('measurements_Anchor2_1.txt','w');
fileID1_3 = fopen('measurements_Anchor3_1.txt','w');
fileID1_4 = fopen('measurements_Anchor4_1.txt','w');

fileID10_1 = fopen('measurements_Anchor1_10.txt','w');
fileID10_2 = fopen('measurements_Anchor2_10.txt','w');
fileID10_3 = fopen('measurements_Anchor3_10.txt','w');
fileID10_4 = fopen('measurements_Anchor4_10.txt','w');

fileID100_1 = fopen('measurements_Anchor1_100.txt','w');
fileID100_2 = fopen('measurements_Anchor2_100.txt','w');
fileID100_3 = fopen('measurements_Anchor3_100.txt','w');
fileID100_4 = fopen('measurements_Anchor4_100.txt','w');

fileID_X = fopen('exactPosX.txt','w');
fileID_Y = fopen('exactPosY.txt','w');
fileID_pos = fopen('exactPos.txt','w');


exactPosX = zeros(Nsamples,1);
exactPosY = zeros(Nsamples,1);


measurement1_001 = zeros(Nsamples,1);
measurement1_01 = zeros(Nsamples,1);
measurement1_1 = zeros(Nsamples,1);
measurement1_10 = zeros(Nsamples,1);
measurement1_100 = zeros(Nsamples,1);

measurement2_001 = zeros(Nsamples,1);
measurement2_01 = zeros(Nsamples,1);
measurement2_1 = zeros(Nsamples,1);
measurement2_10 = zeros(Nsamples,1);
measurement2_100 = zeros(Nsamples,1);

measurement3_001 = zeros(Nsamples,1);
measurement3_01 = zeros(Nsamples,1);
measurement3_1 = zeros(Nsamples,1);
measurement3_10 = zeros(Nsamples,1);
measurement3_100 = zeros(Nsamples,1);

measurement4_001 = zeros(Nsamples,1);
measurement4_01 = zeros(Nsamples,1);
measurement4_1 = zeros(Nsamples,1);
measurement4_10 = zeros(Nsamples,1);
measurement4_100 = zeros(Nsamples,1);

for i = 1:iteration
    for j = 1:Nsamples
        % uniform velocity motion (1,1) ~ (10,10)
        exactPosX(j,1) = j-1;
        exactPosY(j,1) = j-1;
        
        measurement1_001(j,1) = sqrt((exactPosX(j,1)-Anchor.a1(1,1))^2+(exactPosY(j,1)-Anchor.a1(2,1))^2) + sqrt(measurementNoise(1))*randn; % 001
        measurement1_01(j,1) = sqrt((exactPosX(j,1)-Anchor.a1(1,1))^2+(exactPosY(j,1)-Anchor.a1(2,1))^2) + sqrt(measurementNoise(2))*randn; % 01
        measurement1_1(j,1) = sqrt((exactPosX(j,1)-Anchor.a1(1,1))^2+(exactPosY(j,1)-Anchor.a1(2,1))^2) + sqrt(measurementNoise(3))*randn; % 1
        measurement1_10(j,1) = sqrt((exactPosX(j,1)-Anchor.a1(1,1))^2+(exactPosY(j,1)-Anchor.a1(2,1))^2) + sqrt(measurementNoise(4))*randn; % 10
        measurement1_100(j,1) = sqrt((exactPosX(j,1)-Anchor.a1(1,1))^2+(exactPosY(j,1)-Anchor.a1(2,1))^2) + sqrt(measurementNoise(5))*randn; % 100
        
        measurement2_001(j,1) = sqrt((exactPosX(j,1)-Anchor.a2(1,1))^2+(exactPosY(j,1)-Anchor.a2(2,1))^2) + sqrt(measurementNoise(1))*randn; % 001
        measurement2_01(j,1) = sqrt((exactPosX(j,1)-Anchor.a2(1,1))^2+(exactPosY(j,1)-Anchor.a2(2,1))^2) + sqrt(measurementNoise(2))*randn; % 01
        measurement2_1(j,1) = sqrt((exactPosX(j,1)-Anchor.a2(1,1))^2+(exactPosY(j,1)-Anchor.a2(2,1))^2) + sqrt(measurementNoise(3))*randn; % 1
        measurement2_10(j,1) = sqrt((exactPosX(j,1)-Anchor.a2(1,1))^2+(exactPosY(j,1)-Anchor.a2(2,1))^2) + sqrt(measurementNoise(4))*randn; % 10
        measurement2_100(j,1) = sqrt((exactPosX(j,1)-Anchor.a2(1,1))^2+(exactPosY(j,1)-Anchor.a2(2,1))^2) + sqrt(measurementNoise(5))*randn; % 100
        
        measurement3_001(j,1) = sqrt((exactPosX(j,1)-Anchor.a3(1,1))^2+(exactPosY(j,1)-Anchor.a3(2,1))^2) + sqrt(measurementNoise(1))*randn; % 001
        measurement3_01(j,1) = sqrt((exactPosX(j,1)-Anchor.a3(1,1))^2+(exactPosY(j,1)-Anchor.a3(2,1))^2) + sqrt(measurementNoise(2))*randn; % 01
        measurement3_1(j,1) = sqrt((exactPosX(j,1)-Anchor.a3(1,1))^2+(exactPosY(j,1)-Anchor.a3(2,1))^2) + sqrt(measurementNoise(3))*randn; % 1
        measurement3_10(j,1) = sqrt((exactPosX(j,1)-Anchor.a3(1,1))^2+(exactPosY(j,1)-Anchor.a3(2,1))^2) + sqrt(measurementNoise(4))*randn; % 10
        measurement3_100(j,1) = sqrt((exactPosX(j,1)-Anchor.a3(1,1))^2+(exactPosY(j,1)-Anchor.a3(2,1))^2) + sqrt(measurementNoise(5))*randn; % 100
        
        measurement4_001(j,1) = sqrt((exactPosX(j,1)-Anchor.a4(1,1))^2+(exactPosY(j,1)-Anchor.a4(2,1))^2) + sqrt(measurementNoise(1))*randn; % 001
        measurement4_01(j,1) = sqrt((exactPosX(j,1)-Anchor.a4(1,1))^2+(exactPosY(j,1)-Anchor.a4(2,1))^2) + sqrt(measurementNoise(2))*randn; % 01
        measurement4_1(j,1) = sqrt((exactPosX(j,1)-Anchor.a4(1,1))^2+(exactPosY(j,1)-Anchor.a4(2,1))^2) + sqrt(measurementNoise(3))*randn; % 1
        measurement4_10(j,1) = sqrt((exactPosX(j,1)-Anchor.a4(1,1))^2+(exactPosY(j,1)-Anchor.a4(2,1))^2) + sqrt(measurementNoise(4))*randn; % 10
        measurement4_100(j,1) = sqrt((exactPosX(j,1)-Anchor.a4(1,1))^2+(exactPosY(j,1)-Anchor.a4(2,1))^2) + sqrt(measurementNoise(5))*randn; % 100
    end
    % File Write
    fprintf(fileID001_1,'%.3f ',measurement1_001);
    fprintf(fileID001_1,'\n');
    fprintf(fileID001_2,'%.3f ',measurement2_001);
    fprintf(fileID001_2,'\n');
    fprintf(fileID001_3,'%.3f ',measurement3_001);
    fprintf(fileID001_3,'\n');
    fprintf(fileID001_4,'%.3f ',measurement4_001);
    fprintf(fileID001_4,'\n');
    
    fprintf(fileID01_1,'%.3f ',measurement1_01);
    fprintf(fileID01_1,'\n');
    fprintf(fileID01_2,'%.3f ',measurement2_01);
    fprintf(fileID01_2,'\n');
    fprintf(fileID01_3,'%.3f ',measurement3_01);
    fprintf(fileID01_3,'\n');
    fprintf(fileID01_4,'%.3f ',measurement4_01);
    fprintf(fileID01_4,'\n');
    
    fprintf(fileID1_1,'%.3f ',measurement1_1);
    fprintf(fileID1_1,'\n');
    fprintf(fileID1_2,'%.3f ',measurement2_1);
    fprintf(fileID1_2,'\n');
    fprintf(fileID1_3,'%.3f ',measurement3_1);
    fprintf(fileID1_3,'\n');
    fprintf(fileID1_4,'%.3f ',measurement4_1);
    fprintf(fileID1_4,'\n');
    
    fprintf(fileID10_1,'%.3f ',measurement1_10);
    fprintf(fileID10_1,'\n');
    fprintf(fileID10_2,'%.3f ',measurement2_10);
    fprintf(fileID10_2,'\n');
    fprintf(fileID10_3,'%.3f ',measurement3_10);
    fprintf(fileID10_3,'\n');
    fprintf(fileID10_4,'%.3f ',measurement4_10);
    fprintf(fileID10_4,'\n');
    
    fprintf(fileID100_1,'%.3f ',measurement1_100);
    fprintf(fileID100_1,'\n');
    fprintf(fileID100_2,'%.3f ',measurement2_100);
    fprintf(fileID100_2,'\n');
    fprintf(fileID100_3,'%.3f ',measurement3_100);
    fprintf(fileID100_3,'\n');
    fprintf(fileID100_4,'%.3f ',measurement4_100);
    fprintf(fileID100_4,'\n');

    fprintf(fileID_X,'%.3f ',exactPosX);
    fprintf(fileID_X,'\n');
    fprintf(fileID_Y,'%.3f ',exactPosY);
    fprintf(fileID_Y,'\n');
end
pos = [exactPosX exactPosY];
fprintf(fileID_pos,'%.3f ',pos);

fclose("all");

end