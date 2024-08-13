function[all_loc_gap_lpf]=TOA_LPF(iter,NPoints, ...
    D1_Measurement, D2_Measurement, D3_Measurement, D4_Measurement)

H = [0, -20; 20, -20; 20, 0; 20, 0; 20, 20; 0, 20];
H_T = transpose(H);
HTH = H_T * H;
HTH_inv = inv(HTH);

k=1;
alphaMin = zeros(1,9);
for alpha=0.1:0.1:0.9
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
            % lpf part
            if j==1
                x_lpf(i,j) = (1-alpha)*x_toa(i,j);
                y_lpf(i,j) = (1-alpha)*y_toa(i,j);
            else
                x_lpf(i,j) = x_lpf(i,j-1)*alpha + x_toa(i,j)*(1-alpha);
                y_lpf(i,j) = y_lpf(i,j-1)*alpha + y_toa(i,j)*(1-alpha);
            end
            x_gap_lpf(i,j) = j - x_lpf(i,j);
            y_gap_lpf(i,j) = j - y_lpf(i,j);
            loc_gap_lpf(i,j) = sqrt(x_gap_lpf(i,j)^2 + y_gap_lpf(i,j)^2);
        end
    end
    alphaMin(1,k) = sum(loc_gap_lpf,'all')/(iter*(NPoints));
    k=k+1;
end
all_loc_gap_lpf = min(alphaMin);
