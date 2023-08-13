function[] = Measurement_Data2(iter,NPoints,Anchor1,Anchor2,Anchor3,Anchor4) 

% Noise Variance 0.001
Measurement_Noise_Variance = 0.001; %MNV, d(1+n), where n~N(0, MNV), 0.01, 0.1, 1, 10, 100

fileID1_0001 = fopen('Measurement_from_Anchor1_at_MNV_0001.txt','w');
fileID2_0001 = fopen('Measurement_from_Anchor2_at_MNV_0001.txt','w');
fileID3_0001 = fopen('Measurement_from_Anchor3_at_MNV_0001.txt','w');
fileID4_0001 = fopen('Measurement_from_Anchor4_at_MNV_0001.txt','w');
fileID5_0001 = fopen('x_h_at_MNV_0001.txt','w');
fileID6_0001 = fopen('velocity_at_MNV_0001.txt','w');
for num1=1:iter    
    for num2=1:NPoints
        velocity_0001(num1,num2) = velocity_0001(num1,num2-1) + sqrt(Measurement_Noise_Variance)*randn(1);
        x_h_0001(num1,num2) = x_h_0001(num1,num2-1) + velocity_0001(num1,num2) + (1/2)*(sqrt(Measurement_Noise_Variance)*randn(1));
        UserPos = (num2-1)*[1 1];
        Measurement1_0001(num2,1) = (sqrt(sum((Anchor1-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);        
        Measurement2_0001(num2,1) = (sqrt(sum((Anchor2-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement3_0001(num2,1) = (sqrt(sum((Anchor3-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement4_0001(num2,1) = (sqrt(sum((Anchor4-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
    end    
    fprintf(fileID1_0001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement1_0001);
    fprintf(fileID2_0001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement2_0001);
    fprintf(fileID3_0001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement3_0001);
    fprintf(fileID4_0001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement4_0001);    
    fprintf(fileID5_0001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',x_h_0001);    
    fpirntf(fileID6_0001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',velocity_0001);    
end
fclose(fileID1_0001);
fclose(fileID2_0001);
fclose(fileID3_0001);
fclose(fileID4_0001);
fclose(fileID5_0001);
fclose(fileID6_0001);
%S_matrix_0001(num1, num2) = [x_h; velocity];
% Noise Variance 0.01
Measurement_Noise_Variance = 0.01; %MNV, d(1+n), where n~N(0, MNV), 0.01, 0.1, 1, 10, 100

fileID1_001 = fopen('Measurement_from_Anchor1_at_MNV_001.txt','w');
fileID2_001 = fopen('Measurement_from_Anchor2_at_MNV_001.txt','w');
fileID3_001 = fopen('Measurement_from_Anchor3_at_MNV_001.txt','w');
fileID4_001 = fopen('Measurement_from_Anchor4_at_MNV_001.txt','w');
fileID5_001 = fopen('x_h_at_MNV_001.txt','w');
fileID6_001 = fopen('velocity_at_MNV_001.txt','w');

for num1=1:iter    
    for num2=1:NPoints
        UserPos = (num2-1)*[1 1];
        velocity_001(num1,num2) = velocity_001(num1,num2-1) + sqrt(Measurement_Noise_Variance)*randn(1);
        x_h_001(num1,num2) = x_h_001(num1,num2-1) + velocity_001(num1,num2) + (1/2)*(sqrt(Measurement_Noise_Variance)*randn(1));
        Measurement1_001(num2,1) = (sqrt(sum((Anchor1-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);        
        Measurement2_001(num2,1) = (sqrt(sum((Anchor2-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement3_001(num2,1) = (sqrt(sum((Anchor3-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement4_001(num2,1) = (sqrt(sum((Anchor4-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);        
    end
    fprintf(fileID1_001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement1_001);
    fprintf(fileID2_001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement2_001);
    fprintf(fileID3_001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement3_001);
    fprintf(fileID4_001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement4_001);    
    fprintf(fileID5_001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',x_h_001);    
    fpirntf(fileID6_001,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',velocity_001);
end
fclose(fileID1_001);
fclose(fileID2_001);
fclose(fileID3_001);
fclose(fileID4_001);
fclose(fileID5_001);
fclose(fileID6_001);

% Noise Variance 0.1
Measurement_Noise_Variance = 0.1; %MNV, d(1+n), where n~N(0, MNV), 0.01, 0.1, 1, 10, 100

fileID1_01 = fopen('Measurement_from_Anchor1_at_MNV_01.txt','w');
fileID2_01 = fopen('Measurement_from_Anchor2_at_MNV_01.txt','w');
fileID3_01 = fopen('Measurement_from_Anchor3_at_MNV_01.txt','w');
fileID4_01 = fopen('Measurement_from_Anchor4_at_MNV_01.txt','w');
fileID5_01 = fopen('x_h_at_MNV_01.txt','w');
fileID6_01 = fopen('velocity_at_MNV_01.txt','w');

for num1=1:iter    
    for num2=1:NPoints
        velocity_01(num1,num2) = velocity_01(num1,num2-1) + sqrt(Measurement_Noise_Variance)*randn(1);
        x_h_01(num1,num2) = x_h_01(num1,num2-1) + velocity_01(num1,num2) + (1/2)*(sqrt(Measurement_Noise_Variance)*randn(1));
        UserPos = (num2-1)*[1 1];
        Measurement1_01(num2,1) = (sqrt(sum((Anchor1-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);        
        Measurement2_01(num2,1) = (sqrt(sum((Anchor2-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement3_01(num2,1) = (sqrt(sum((Anchor3-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement4_01(num2,1) = (sqrt(sum((Anchor4-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);        
    end
    fprintf(fileID1_01,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement1_01);
    fprintf(fileID2_01,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement2_01);
    fprintf(fileID3_01,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement3_01);
    fprintf(fileID4_01,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement4_01); 
    fprintf(fileID5_01,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',x_h_01);    
    fpirntf(fileID6_01,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',velocity_01);
end
fclose(fileID1_01);
fclose(fileID2_01);
fclose(fileID3_01);
fclose(fileID4_01);
fclose(fileID5_01);
fclose(fileID6_01);

% Noise Variance 1
Measurement_Noise_Variance = 1; %MNV, d(1+n), where n~N(0, MNV), 0.01, 0.1, 1, 10, 100

Measurement = zeros(NPoints,1);

fileID1_1 = fopen('Measurement_from_Anchor1_at_MNV_1.txt','w');
fileID2_1 = fopen('Measurement_from_Anchor2_at_MNV_1.txt','w');
fileID3_1 = fopen('Measurement_from_Anchor3_at_MNV_1.txt','w');
fileID4_1 = fopen('Measurement_from_Anchor4_at_MNV_1.txt','w');
fileID5_1 = fopen('x_h_at_MNV_1.txt','w');
fileID6_1 = fopen('velocity_at_MNV_1.txt','w');


for num1=1:iter    
    for num2=1:NPoints
        UserPos = (num2-1)*[1 1];
        velocity_1(num1,num2) = velocity_1(num1,num2-1) + sqrt(Measurement_Noise_Variance)*randn(1);
        x_h_1(num1,num2) = x_h_1(num1,num2-1) + velocity_1(num1,num2) + (1/2)*(sqrt(Measurement_Noise_Variance)*randn(1));
        Measurement1_1(num2,1) = (sqrt(sum((Anchor1-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);        
        Measurement2_1(num2,1) = (sqrt(sum((Anchor2-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement3_1(num2,1) = (sqrt(sum((Anchor3-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement4_1(num2,1) = (sqrt(sum((Anchor4-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);       
    end
    fprintf(fileID1_1,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement1_1);
    fprintf(fileID2_1,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement2_1);
    fprintf(fileID3_1,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement3_1);
    fprintf(fileID4_1,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement4_1);  
    fprintf(fileID5_1,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',x_h_1);    
    fpirntf(fileID6_1,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',velocity_1);
end
fclose(fileID1_1);
fclose(fileID2_1);
fclose(fileID3_1);
fclose(fileID4_1);
fclose(fileID5_1);
fclose(fileID6_1);

% Noise Variance 10
Measurement_Noise_Variance = 10; %MNV, d(1+n), where n~N(0, MNV), 0.01, 0.1, 1, 10, 100

Measurement = zeros(NPoints,1);

fileID1_10 = fopen('Measurement_from_Anchor1_at_MNV_10.txt','w');
fileID2_10 = fopen('Measurement_from_Anchor2_at_MNV_10.txt','w');
fileID3_10 = fopen('Measurement_from_Anchor3_at_MNV_10.txt','w');
fileID4_10 = fopen('Measurement_from_Anchor4_at_MNV_10.txt','w');
fileID5_10 = fopen('x_h_at_MNV_10.txt','w');
fileID6_10 = fopen('velocity_at_MNV_10.txt','w');

for num1=1:iter    
    for num2=1:NPoints
        velocity_10(num1,num2) = velocity_10(num1,num2-1) + sqrt(Measurement_Noise_Variance)*randn(1);
        x_h_10(num1,num2) = x_h_10(num1,num2-1) + velocity_10(num1,num2) + (1/2)*(sqrt(Measurement_Noise_Variance)*randn(1));
        UserPos = (num2-1)*[1 1];
        Measurement1_10(num2,1) = (sqrt(sum((Anchor1-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);        
        Measurement2_10(num2,1) = (sqrt(sum((Anchor2-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement3_10(num2,1) = (sqrt(sum((Anchor3-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement4_10(num2,1) = (sqrt(sum((Anchor4-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);    
    end
    fprintf(fileID1_10,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement1_10);
    fprintf(fileID2_10,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement2_10);
    fprintf(fileID3_10,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement3_10);
    fprintf(fileID4_10,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement4_10);    
    fprintf(fileID5_10,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',x_h_10);    
    fpirntf(fileID6_10,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',velocity_10);
end
fclose(fileID1_10);
fclose(fileID2_10);
fclose(fileID3_10);
fclose(fileID4_10);
fclose(fileID5_10);
fclose(fileID6_10);

% Noise Variance 100
Measurement_Noise_Variance = 100; %MNV, d(1+n), where n~N(0, MNV), 0.01, 0.1, 1, 10, 100

Measurement = zeros(NPoints,1);

fileID1_100 = fopen('Measurement_from_Anchor1_at_MNV_100.txt','w');
fileID2_100 = fopen('Measurement_from_Anchor2_at_MNV_100.txt','w');
fileID3_100 = fopen('Measurement_from_Anchor3_at_MNV_100.txt','w');
fileID4_100 = fopen('Measurement_from_Anchor4_at_MNV_100.txt','w');
fileID5_100 = fopen('x_h_at_MNV_100.txt','w');
fileID6_100 = fopen('velocity_at_MNV_100.txt','w');

for num1=1:iter    
    for num2=1:NPoints
        velocity_100(num1,num2) = velocity_100(num1,num2-1) + sqrt(Measurement_Noise_Variance)*randn(1);
        x_h_100(num1,num2) = x_h_100(num1,num2-1) + velocity_100(num1,num2) + (1/2)*(sqrt(Measurement_Noise_Variance)*randn(1));
        UserPos = (num2-1)*[1 1];
        Measurement1_100(num2,1) = (sqrt(sum((Anchor1-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);        
        Measurement2_100(num2,1) = (sqrt(sum((Anchor2-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement3_100(num2,1) = (sqrt(sum((Anchor3-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
        Measurement4_100(num2,1) = (sqrt(sum((Anchor4-UserPos).^2))+ sqrt(Measurement_Noise_Variance)*randn);
    end
    fprintf(fileID1_100,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement1_100);
    fprintf(fileID2_100,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement2_100);
    fprintf(fileID3_100,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement3_100);
    fprintf(fileID4_100,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',Measurement4_100);    
    fprintf(fileID5_100,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',x_h_100);    
    fpirntf(fileID6_100,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',velocity_100);
end
fclose(fileID1_100);
fclose(fileID2_100);
fclose(fileID3_100);
fclose(fileID4_100);
fclose(fileID5_100);
fclose(fileID6_100);