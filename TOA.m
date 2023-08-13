function[x_toa,y_toa,all_gap_loc,F,LPF] = TOA(iter,NPoints,D1_Measurement, D2_Measurement, D3_Measurement, D4_Measurement)
%H matrix Z=Hx

MFV = 4; %이동평균필터 크기
LPF_a = 0.4;  %LPF Alpha Degree

x_lpf = zeros(iter,NPoints);
y_lpf = zeros(iter,NPoints);

H = [0, -20; 20, -20; 20, 0; 20, 0; 20, 20; 0, 20];
H_T = transpose(H);
HTH = H_T * H;
HTH_inv = inv(HTH);
% x=H^-1 Z
x_gap = zeros(iter, NPoints);
y_gap = zeros(iter, NPoints);

loc_gap = zeros(iter, NPoints);
loc_gap_Filter1 = zeros(iter, NPoints-MFV+1);
loc_gap_lpf = zeros(iter,NPoints-1);
Moving_Mean_Filter_x = zeros(iter, NPoints);
Moving_Mean_Filter_y = zeros(iter, NPoints);

x = zeros(1, NPoints);
y = zeros(1, NPoints);
Location = [x;
    y];

for i = 1:iter
    for j = 1:NPoints
        Z(1,j) = (D1_Measurement(i,j))^2 - (D2_Measurement(i,j))^2 -100;
        Z(2,j) = (D1_Measurement(i,j))^2 - (D3_Measurement(i,j))^2;
        Z(3,j) = (D1_Measurement(i,j))^2 - (D4_Measurement(i,j))^2 + 100;
        Z(4,j) = (D2_Measurement(i,j))^2 - (D3_Measurement(i,j))^2 + 100;
        Z(5,j) = (D2_Measurement(i,j))^2 - (D4_Measurement(i,j))^2 + 200;
        Z(6,j) = (D3_Measurement(i,j))^2 - (D4_Measurement(i,j))^2 + 100;
        
        Location(:,j) = HTH_inv * H_T * Z(:,j);
        x_toa(i,j) = Location(1,j);
        y_toa(i,j) = Location(2,j);
        x_gap(i,j) = (j-1) - Location(1,j);
        y_gap(i,j) = (j-1) - Location(2,j);
        loc_gap(i,j) = sqrt(x_gap(i,j)^2 + y_gap(i,j)^2);
        
        %크기가 MFV인 이동평균필터
        if j>=MFV
            for k = 1:MFV
                Moving_Mean_Filter_x(i,j) = Moving_Mean_Filter_x(i,j) + x_toa(i,j-k+1);
                Moving_Mean_Filter_y(i,j) = Moving_Mean_Filter_y(i,j) + y_toa(i,j-k+1);
            end
            Filtered_Data_x(i,j-MFV+1) = Moving_Mean_Filter_x(i,j)/MFV ;
            Filtered_Data_y(i,j-MFV+1) = Moving_Mean_Filter_y(i,j)/MFV ;
            x_gap_f(i,j-MFV+1) = (j-1) - Filtered_Data_x(i,j-MFV+1);
            y_gap_f(i,j-MFV+1) = (j-1) - Filtered_Data_y(i,j-MFV+1);
            loc_gap_Filter1(i,j-MFV+1) = sqrt(x_gap_f(i,j-MFV+1)^2 + y_gap_f(i,j-MFV+1)^2);
        end
        %LPF_A를 알파로 갖는 Low pass Filter
        if j>1
            x_lpf(i,j) = LPF_a*x_lpf(i,j-1) + (1-LPF_a)*x_toa(i,j-1);
            y_lpf(i,j) = LPF_a*y_lpf(i,j-1) + (1-LPF_a)*y_toa(i,j-1);
            x_gap_lpf(i,j-1) = (j-1) - x_lpf(i,j);
            y_gap_lpf(i,j-1) = (j-1) - y_lpf(i,j);
            loc_gap_lpf(i,j-1) = sqrt(x_gap_lpf(i,j-1)^2 + y_gap_lpf(i,j-1)^2);
        end


    end
end
F = sum(loc_gap_Filter1,"all")/(iter*(NPoints-MFV+1));
LPF = sum(loc_gap_lpf,'all')/(iter*(NPoints-1));
all_gap_loc = sum(loc_gap,"all")/(iter*NPoints);