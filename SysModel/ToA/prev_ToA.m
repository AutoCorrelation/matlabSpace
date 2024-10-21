function[Loc_Err] = prev_ToA(iteration,Nsamples,AnchorMax1,AnchorMax2)
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

exactPosX = load("exactPosX.txt");
exactPosY = load("exactPosY.txt");
% fileID001 = fopen('ToA_State001.txt','w');
% fileID01 = fopen('ToA_State01.txt','w');
% fileID1 = fopen('ToA_State1.txt','w');
% fileID10 = fopen('ToA_State10.txt','w');
% fileID100 = fopen('ToA_State100.txt','w');

ToA_State001 = zeros(2,Nsamples);
ToA_State01 = zeros(2,Nsamples);
ToA_State1 = zeros(2,Nsamples);
ToA_State10 = zeros(2,Nsamples);
ToA_State100 = zeros(2,Nsamples);

%% Recursive Form
% persistent Loc_Err001 Loc_Err01 Loc_Err1 Loc_Err10 Loc_Err100
% persistent firstRun

Loc_Err001 = zeros(iteration,Nsamples);
Loc_Err01 = zeros(iteration,Nsamples);
Loc_Err1 = zeros(iteration,Nsamples);
Loc_Err10 = zeros(iteration,Nsamples);
Loc_Err100 = zeros(iteration,Nsamples);

H = [...
    0, -2*AnchorMax2
    2*AnchorMax1, -2*AnchorMax2
    2*AnchorMax1, 0
    2*AnchorMax1, 0
    2*AnchorMax1, 2*AnchorMax2
    0, 2*AnchorMax2];

H_pseudoInv = (H'*H)\H';

for i = 1:iteration
    for j = 1:Nsamples
        D001 = [...
            measurement1_001(i,j)^2 - measurement2_001(i,j)^2 - AnchorMax2^2
            measurement1_001(i,j)^2 - measurement3_001(i,j)^2 + AnchorMax1^2 - AnchorMax2^2
            measurement1_001(i,j)^2 - measurement4_001(i,j)^2 + AnchorMax1^2
            measurement2_001(i,j)^2 - measurement3_001(i,j)^2 + AnchorMax1^2
            measurement2_001(i,j)^2 - measurement4_001(i,j)^2 + AnchorMax1^2 + AnchorMax2^2
            measurement3_001(i,j)^2 - measurement4_001(i,j)^2 + AnchorMax2^2];
        
        D01 = [...
            measurement1_01(i,j)^2 - measurement2_01(i,j)^2 - AnchorMax2^2
            measurement1_01(i,j)^2 - measurement3_01(i,j)^2 + AnchorMax1^2 - AnchorMax2^2
            measurement1_01(i,j)^2 - measurement4_01(i,j)^2 + AnchorMax1^2
            measurement2_01(i,j)^2 - measurement3_01(i,j)^2 + AnchorMax1^2
            measurement2_01(i,j)^2 - measurement4_01(i,j)^2 + AnchorMax1^2 + AnchorMax2^2
            measurement3_01(i,j)^2 - measurement4_01(i,j)^2 + AnchorMax2^2];
        
        D1 = [...
            measurement1_1(i,j)^2 - measurement2_1(i,j)^2 - AnchorMax2^2
            measurement1_1(i,j)^2 - measurement3_1(i,j)^2 + AnchorMax1^2 - AnchorMax2^2
            measurement1_1(i,j)^2 - measurement4_1(i,j)^2 + AnchorMax1^2
            measurement2_1(i,j)^2 - measurement3_1(i,j)^2 + AnchorMax1^2
            measurement2_1(i,j)^2 - measurement4_1(i,j)^2 + AnchorMax1^2 + AnchorMax2^2
            measurement3_1(i,j)^2 - measurement4_1(i,j)^2 + AnchorMax2^2];
        
        D10 = [...
            measurement1_10(i,j)^2 - measurement2_10(i,j)^2 - AnchorMax2^2
            measurement1_10(i,j)^2 - measurement3_10(i,j)^2 + AnchorMax1^2 - AnchorMax2^2
            measurement1_10(i,j)^2 - measurement4_10(i,j)^2 + AnchorMax1^2
            measurement2_10(i,j)^2 - measurement3_10(i,j)^2 + AnchorMax1^2
            measurement2_10(i,j)^2 - measurement4_10(i,j)^2 + AnchorMax1^2 + AnchorMax2^2
            measurement3_10(i,j)^2 - measurement4_10(i,j)^2 + AnchorMax2^2];
        
        D100 = [...
            measurement1_100(i,j)^2 - measurement2_100(i,j)^2 - AnchorMax2^2
            measurement1_100(i,j)^2 - measurement3_100(i,j)^2 + AnchorMax1^2 - AnchorMax2^2
            measurement1_100(i,j)^2 - measurement4_100(i,j)^2 + AnchorMax1^2
            measurement2_100(i,j)^2 - measurement3_100(i,j)^2 + AnchorMax1^2
            measurement2_100(i,j)^2 - measurement4_100(i,j)^2 + AnchorMax1^2 + AnchorMax2^2
            measurement3_100(i,j)^2 - measurement4_100(i,j)^2 + AnchorMax2^2];
        
        ToA_State001(:,j) = H_pseudoInv*D001;
        ToA_State01(:,j) = H_pseudoInv*D01;
        ToA_State1(:,j) = H_pseudoInv*D1;
        ToA_State10(:,j) = H_pseudoInv*D10;
        ToA_State100(:,j) = H_pseudoInv*D100;
        
        exactPos = [exactPosX(i,j);exactPosY(i,j)];

        % Average Recursive expression
        Loc_Err001(i,j) = norm(exactPos-ToA_State001(:,j));
        Loc_Err01(i,j) = norm(exactPos-ToA_State01(:,j));
        Loc_Err1(i,j) = norm(exactPos-ToA_State1(:,j));
        Loc_Err10(i,j) = norm(exactPos-ToA_State10(:,j));
        Loc_Err100(i,j) = norm(exactPos-ToA_State100(:,j));


        
        %% Recursive Form
        % if (isempty(firstRun))
        %     % Average Recursive expression
        %     Loc_Err001 = norm(exactPos-ToA_State001(:,j));
        %     Loc_Err01 = norm(exactPos-ToA_State01(:,j));
        %     Loc_Err1 = norm(exactPos-ToA_State1(:,j));
        %     Loc_Err10 = norm(exactPos-ToA_State10(:,j));
        %     Loc_Err100 = norm(exactPos-ToA_State100(:,j));
        % 
        %     firstRun = 1;
        % end
        % alpha = (1-1/(i+j));
        % Loc_Err001 = alpha*(Loc_Err001)+(1-alpha)*(norm(exactPos-ToA_State001(:,j)));
        % Loc_Err01 = alpha*(Loc_Err01)+(1-alpha)*(norm(exactPos-ToA_State01(:,j)));
        % Loc_Err1 = alpha*(Loc_Err1)+(1-alpha)*(norm(exactPos-ToA_State1(:,j)));
        % Loc_Err10 = alpha*(Loc_Err10)+(1-alpha)*(norm(exactPos-ToA_State10(:,j)));
        % Loc_Err100 = alpha*(Loc_Err100)+(1-alpha)*(norm(exactPos-ToA_State100(:,j)));

    end
        % fprintf(fileID001,'%.3f',ToA_State001(:,:));
        % fprintf(fileID001,'\n');
        % fprintf(fileID01,'%.3f',ToA_State01(:,:));
        % fprintf(fileID01,'\n');
        % fprintf(fileID1,'%.3f',ToA_State1(:,:));
        % fprintf(fileID1,'\n');
        % fprintf(fileID10,'%.3f',ToA_State10(:,:));
        % fprintf(fileID10,'\n');
        % fprintf(fileID100,'%.3f',ToA_State100(:,:));
        % fprintf(fileID1,'\n');
end
fclose("all");
%% Recursive Form
% Loc_Err = [...
%     Loc_Err001;
%     Loc_Err01;
%     Loc_Err1;
%     Loc_Err10;
%     Loc_Err100
%     ];

Loc_Err = [...
    sum(Loc_Err001,"all")/(iteration*Nsamples);
    sum(Loc_Err01,"all")/(iteration*Nsamples);
    sum(Loc_Err1,"all")/(iteration*Nsamples);
    sum(Loc_Err10,"all")/(iteration*Nsamples);
    sum(Loc_Err100,"all")/(iteration*Nsamples)
    ];

end