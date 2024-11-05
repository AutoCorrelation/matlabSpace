function[meas_x, meas_y, v_ErrLoc] = prev_ToA(Anchor, measurements, iter, num)
persistent firstRun
persistent H_pseudoInv exactPosX exactPosY d1 d2

if isempty(firstRun)
    firstRun=1;
    d1 = Anchor.a4(1);
    d2 = Anchor.a4(2);
    H = [...
        0, -2*d2
        2*d1, -2*d2
        2*d1, 0
        2*d1, 0
        2*d1, 2*d2
        0, 2*d2];
    H_pseudoInv = (H'*H)\H';
    exactPosX = load("exactPosX.txt");
    exactPosY = load("exactPosY.txt");
end

exactPos = [exactPosX(iter,num);exactPosY(iter,num)];

D = [...
measurements.a1(iter,num)^2 - measurements.a2(iter,num)^2 - d2^2
measurements.a1(iter,num)^2 - measurements.a3(iter,num)^2 + d1^2 - d2^2
measurements.a1(iter,num)^2 - measurements.a4(iter,num)^2 + d1^2
measurements.a2(iter,num)^2 - measurements.a3(iter,num)^2 + d1^2
measurements.a2(iter,num)^2 - measurements.a4(iter,num)^2 + d1^2 + d2^2
measurements.a3(iter,num)^2 - measurements.a4(iter,num)^2 + d2^2 ];

vec_ToA = H_pseudoInv * D;
meas_x = vec_ToA(1);
meas_y = vec_ToA(2);

v_ErrLoc = exactPos - vec_ToA;

end

