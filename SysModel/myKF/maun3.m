% Main.m
% Monte-Carlo simulation for calculating positioning accuracy based on
% Time of Arrival (ToA) algorithm
clear all;
format long e;
% Main parameters
Anchor1Pos = [0;10];
Anchor2Pos = [0;0];
Anchor3Pos = [10;0];
Anchor4Pos = [10;10];
MaxNumforPositioningAccuracy = 1e3;
%ToA parameter
NoiseVar = [sqrt(0.01) sqrt(0.1) sqrt(1) sqrt(10) sqrt(100)];
AC = zeros(5,1);
ErrorPos_ToA = zeros(1,MaxNumforPositioningAccuracy*11);
%LPF parameter
ErrorPos_LPF = zeros(1,MaxNumforPositioningAccuracy*11);
AC_LPF = zeros(5,1);
alpha = [0.99 0.95 0.77 0.47 0.14];
%predition param
A = [1 0;0 1];
dt = 0.1;
W = [-0.00163482027260359	0.00781541664168247	-0.00612974891347566	0.0733379197561472	-0.239175110922281;
    0.00106236574020402	0.00318366559576308	-0.0248054913170219	0.0211535243294397	-0.144477586702038];


ErrorPos_pre = zeros(1,MaxNumforPositioningAccuracy*11);
Alpha_Pre = [6.210526315789474e-01 6.210526315789474e-01 6.684210526315789e-01 7.157894736842105e-01 7.157894736842105e-01];
AC_Pre = zeros(5,1);
%KF
H =  [0 -20; 20 -20; 20 0; 20 0; 20 20; 0 20];
P_0 = zeros(2,2,5);
P_0(:,:,1) = [0.0304514450162361    -5.21832106116210e-05;
    -5.21832106116210e-05     0.0304397147489163];
P_0(:,:,2) = [0.305042851581433    -0.000316114366443831;
    -0.000316114366443831     0.304839671088899];
P_0(:,:,3) = [3.07978735404596     0.00647829338090575;
    0.00647829338090575     3.07735147375099];
P_0(:,:,4) = [33.0365557263871     0.0449678612933257;
    0.0449678612933257     33.0071716542862];
P_0(:,:,5) = [653.528491169714    -0.803898422286800;
    -0.803898422286800   654.400843564141];

Q(:,:,1) = [0.0156737649287885    -0.000641620621241766;
    -0.000641620621241766     0.0156507808715411];
Q(:,:,2) = [0.157717838181395    -0.00771971143766273;
    -0.00771971143766273     0.156947963970796];
Q(:,:,3) = [1.58080159704824     -0.0818434374404879;
    -0.0818434374404879     1.59800574240914];
Q(:,:,4) = [15.5904587675953     -0.404401690470355;
    -0.404401690470355     15.2343417433597];
Q(:,:,5) = [172.288490471848    1.78106429329443;
    1.78106429329443   173.854089938549];
AC_KF = zeros(5,1);
ErrorPos_KF = zeros(5,MaxNumforPositioningAccuracy*11);
%KF_EV1
AC_EV = zeros(5,1);
ErrorPos_EV = zeros(5,MaxNumforPositioningAccuracy);
r_1 = [0.39 0.39 0.39 0.51 0.51];
% %KF_EV2
AC_EV2 = zeros(5,1);
ErrorPos_EV2 = zeros(5,MaxNumforPositioningAccuracy);
r_2 = [0.2 0.2 0.2 0.1 0.3]; 
%KF_EV3
AC_EV3 = zeros(5,1);
ErrorPos_EV3 = zeros(5,MaxNumforPositioningAccuracy);
r_3 = 1.1;
for numforNoiseVar = 1:5

    for numforPositioningAccuracy = 1:MaxNumforPositioningAccuracy
        estimatedPos_LPF = [NoiseVar(numforNoiseVar)*randn;NoiseVar(numforNoiseVar)*randn];
        estimatedPosX = 0;
        estimatedPosY = 0;
        VX_predition = [0;0];
        for i = 1:11
            exactPosX = i-1;
            exactPosY = i-1;
            exactPos = [exactPosX;exactPosY];
            rangingfromAnchor1 = norm(Anchor1Pos-exactPos) + NoiseVar(numforNoiseVar)*randn;
            rangingfromAnchor2 = norm(Anchor2Pos-exactPos) + NoiseVar(numforNoiseVar)*randn;
            rangingfromAnchor3 = norm(Anchor3Pos-exactPos) + NoiseVar(numforNoiseVar)*randn;
            rangingfromAnchor4 = norm(Anchor4Pos-exactPos) + NoiseVar(numforNoiseVar)*randn;
            %ToA
            [estimatedPosX,estimatedPosY]= ToAalg(rangingfromAnchor1,rangingfromAnchor2,rangingfromAnchor3,rangingfromAnchor4);
            ErrorPos_ToA(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) = norm(exactPos-[estimatedPosX;estimatedPosY]);
            %LPF
            estimatedPos_LPF = (1-alpha(numforNoiseVar))*estimatedPos_LPF+ alpha(numforNoiseVar)*[estimatedPosX;estimatedPosY];
            ErrorPos_LPF(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - estimatedPos_LPF);

         
            if i <= 2
                [estimatedPosX,estimatedPosY]= ToAalg(rangingfromAnchor1,rangingfromAnchor2,rangingfromAnchor3,rangingfromAnchor4);
                prevPos = [estimatedPosX;estimatedPosY];
                ErrorPos_pre(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - [estimatedPosX;estimatedPosY]);
                ErrorPos_KF(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - [estimatedPosX;estimatedPosY]);
                ErrorPos_EV(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - [estimatedPosX;estimatedPosY]);
                ErrorPos_EV2(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - [estimatedPosX;estimatedPosY]);
                ErrorPos_EV3(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - [estimatedPosX;estimatedPosY]);
            elseif i == 3
                [estimatedPosX,estimatedPosY]= ToAalg(rangingfromAnchor1,rangingfromAnchor2,rangingfromAnchor3,rangingfromAnchor4);
                VX_predition = ([estimatedPosX;estimatedPosY]-prevPos)/dt;
                VX = ([estimatedPosX;estimatedPosY]-prevPos)/dt;
                VX_EV = ([estimatedPosX;estimatedPosY]-prevPos)/dt;
                VX_EV2 = ([estimatedPosX;estimatedPosY]-prevPos)/dt;
                VX_EV3 = ([estimatedPosX;estimatedPosY]-prevPos)/dt;
                prevPos_KF = [estimatedPosX;estimatedPosY];
                prevPos_LPF = [estimatedPosX;estimatedPosY];
                prevPos_EV = [estimatedPosX;estimatedPosY];
                prevPos_EV2 = [estimatedPosX;estimatedPosY];
                prevPos_EV3 = [estimatedPosX;estimatedPosY];
                ErrorPos_pre(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - [estimatedPosX;estimatedPosY]);
                ErrorPos_KF(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - [estimatedPosX;estimatedPosY]);
                ErrorPos_EV(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - [estimatedPosX;estimatedPosY]);
                ErrorPos_EV2(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - [estimatedPosX;estimatedPosY]);
                ErrorPos_EV3(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - [estimatedPosX;estimatedPosY]);
            else
                [estimatedPosX,estimatedPosY]= ToAalg(rangingfromAnchor1,rangingfromAnchor2,rangingfromAnchor3,rangingfromAnchor4);
                
                Predition = A*prevPos_LPF + VX_predition*dt - [W(1,numforNoiseVar); W(2,numforNoiseVar)];
                predition_KF = A*prevPos_KF + VX*dt - [W(1,numforNoiseVar); W(2,numforNoiseVar)];
                predition_EV = A*prevPos_EV + VX_EV*dt - [W(1,numforNoiseVar); W(2,numforNoiseVar)];
                predition_EV2 = A*prevPos_EV2 + VX_EV2*dt - [W(1,numforNoiseVar); W(2,numforNoiseVar)];
                predition_EV3 = A*prevPos_EV3 + VX_EV3*dt - [W(1,numforNoiseVar); W(2,numforNoiseVar)];
                predition_LPF = (1-Alpha_Pre(numforNoiseVar))*Predition + Alpha_Pre(numforNoiseVar)*[estimatedPosX;estimatedPosY];
                if i == 4
                    predition_P = P_0(:, :, numforNoiseVar);
                    predition_PEV = P_0(:, :, numforNoiseVar);
                    predition_PEV2 = P_0(:, :, numforNoiseVar);
                    predition_PEV3 = P_0(:, :, numforNoiseVar);
                else 
                    predition_P = A*P*A + Q(:,:,numforNoiseVar);
                    predition_PEV = A*P_EV*A + r_1(numforNoiseVar)*Q(:,:,numforNoiseVar);
                    predition_PEV2 = A*P_EV2*A + exp(-r_2(numforNoiseVar)*(i-4))*Q(:,:,numforNoiseVar);
                    predition_PEV3 = A*P_EV3*A + (r_3/log(i-3))*Q(:,:,numforNoiseVar);
                end
                Zk = [rangingfromAnchor1^2 - rangingfromAnchor2^2 - 100;
                    rangingfromAnchor1^2 - rangingfromAnchor3^2;
                    rangingfromAnchor1^2 - rangingfromAnchor4^2 + 100;
                    rangingfromAnchor2^2 - rangingfromAnchor3^2 + 100;
                    rangingfromAnchor2^2 - rangingfromAnchor4^2 + 200;
                    rangingfromAnchor3^2 - rangingfromAnchor4^2 + 100];
                R = [4*NoiseVar(numforNoiseVar)^2*(rangingfromAnchor1^2+rangingfromAnchor2^2) 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor1^2 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor1^2 -4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor2^2 -4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor2^2 0;
                    4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor1^2 4*NoiseVar(numforNoiseVar)^2*(rangingfromAnchor1^2+rangingfromAnchor3^2) 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor1^2 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor3^2 0 -4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor3^2;
                    4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor1^2 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor1^2 4*NoiseVar(numforNoiseVar)^2*(rangingfromAnchor1^2+rangingfromAnchor4^2) 0 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor4^2 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor4^2;
                    -4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor2^2 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor3^2 0 4*NoiseVar(numforNoiseVar)^2*(rangingfromAnchor2^2+rangingfromAnchor3^2) 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor2^2 -4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor3^2;
                    -4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor2^2 0 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor4^2 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor2^2 4*NoiseVar(numforNoiseVar)^2*(rangingfromAnchor2^2+rangingfromAnchor4^2) 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor4^2;
                    0 -4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor2^2 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor4^2 -4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor3^2 4*NoiseVar(numforNoiseVar)^2*rangingfromAnchor4^2 4*NoiseVar(numforNoiseVar)^2*(rangingfromAnchor3^2+rangingfromAnchor4^2)];
                K = predition_P * transpose(H) * pinv(H * predition_P * transpose(H) + R);
                K_EV = predition_PEV * transpose(H) * pinv(H * predition_PEV * transpose(H) + R);
                K_EV2 = predition_PEV2 * transpose(H) * pinv(H * predition_PEV2 * transpose(H) + R);
                 K_EV3 = predition_PEV3 * transpose(H) * pinv(H * predition_PEV3 * transpose(H) + R);
                estimatedpos_KF = predition_KF + K * (Zk - H * predition_KF);
                estimatedpos_KFEV = predition_EV + K_EV * (Zk - H * predition_EV);
                estimatedpos_KFEV2 = predition_EV2 + K_EV2 * (Zk - H * predition_EV2);
                estimatedpos_KFEV3 = predition_EV3 + K_EV3 * (Zk - H * predition_EV3);
                P = predition_P - K * H * predition_P;
                P_EV = predition_PEV - K_EV * H * predition_PEV;
                P_EV2 = predition_PEV2 - K_EV2 * H * predition_PEV2;
                P_EV3 = predition_PEV3 - K_EV3 * H * predition_PEV3;
                VX = (estimatedpos_KF - prevPos_KF) / dt;
                VX_predition = (predition_LPF-prevPos_LPF)/dt;
                VX_EV = (estimatedpos_KFEV - prevPos_EV) / dt;
                VX_EV2 = (estimatedpos_KFEV2 - prevPos_EV2) / dt;
                VX_EV3 = (estimatedpos_KFEV3 - prevPos_EV3) / dt;
                prevPos_LPF = predition_LPF;
                prevPos_KF = estimatedpos_KF;
                prevPos_EV = estimatedpos_KFEV;
                prevPos_EV2 = estimatedpos_KFEV2;
                prevPos_EV3 = estimatedpos_KFEV3;
                ErrorPos_pre(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - predition_LPF);
                ErrorPos_KF(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - estimatedpos_KF);
                ErrorPos_EV(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - estimatedpos_KFEV);
                ErrorPos_EV2(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - estimatedpos_KFEV2);
                ErrorPos_EV3(numforNoiseVar,(numforPositioningAccuracy-1)*11+i) =norm(exactPos - estimatedpos_KFEV3);
            end
            
        end
    end




    AC(numforNoiseVar) = mean(ErrorPos_ToA(numforNoiseVar,:));
    AC_LPF(numforNoiseVar) = mean(ErrorPos_LPF(numforNoiseVar,:));
    AC_Pre(numforNoiseVar) = mean(ErrorPos_pre(numforNoiseVar,:));
    AC_KF(numforNoiseVar) = mean(ErrorPos_KF(numforNoiseVar,:));
    AC_EV(numforNoiseVar) = mean(ErrorPos_EV(numforNoiseVar,:));
    AC_EV2(numforNoiseVar) = mean(ErrorPos_EV2(numforNoiseVar,:));
    AC_EV3(numforNoiseVar) = mean(ErrorPos_EV3(numforNoiseVar,:));
end
semilogx([0.01 0.1 1 10 100], AC, '-s', 'DisplayName', 'ToA');
hold on;
semilogx([0.01 0.1 1 10 100], AC_LPF, '-s', 'DisplayName', 'LPF');
semilogx([0.01 0.1 1 10 100], AC_Pre, '-s', 'DisplayName', 'Pre+LPF');
semilogx([0.01 0.1 1 10 100], AC_KF, '-s', 'DisplayName', 'KF');
semilogx([0.01 0.1 1 10 100], AC_EV, '-s', 'DisplayName', 'KF_EV');
semilogx([0.01 0.1 1 10 100], AC_EV2, '-s', 'DisplayName', 'KF_EV2');
semilogx([0.01 0.1 1 10 100], AC_EV3, '-s', 'DisplayName', 'KF_EV3');
xlabel('Noise Variance');
ylabel('Accuracy');
legend show;
grid on;