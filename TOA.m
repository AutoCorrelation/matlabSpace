function[all_loc_gap]=TOA(iter,NPoints, ...
    D1_Measurement, D2_Measurement, D3_Measurement, D4_Measurement)

H = [0, -20; 20, -20; 20, 0; 20, 0; 20, 20; 0, 20];
H_T = transpose(H);
HTH = H_T * H;
HTH_inv = inv(HTH);

for i=1:iter
    for j=1:NPoints
        Z(1,j) = (D1_Measurement(i,j))^2 - (D2_Measurement(i,j))^2 -100;
        Z(2,j) = (D1_Measurement(i,j))^2 - (D3_Measurement(i,j))^2;
        Z(3,j) = (D1_Measurement(i,j))^2 - (D4_Measurement(i,j))^2 + 100;
        Z(4,j) = (D2_Measurement(i,j))^2 - (D3_Measurement(i,j))^2 + 100;
        Z(5,j) = (D2_Measurement(i,j))^2 - (D4_Measurement(i,j))^2 + 200;
        Z(6,j) = (D3_Measurement(i,j))^2 - (D4_Measurement(i,j))^2 + 100;

        Loc(:,j) = HTH_inv*H_T*Z(:,j);
        x_toa(i,j) = Loc(1,j);
        y_toa(i,j) = Loc(2,j);
        x_gap(i,j) = (j) - Loc(1,j);
        y_gap(i,j) = (j) - Loc(2,j);
        loc_gap(i,j) = sqrt(x_gap(i,j)^2 + y_gap(i,j)^2);
    end
end
all_loc_gap = sum(loc_gap,"all")/(iter*NPoints);