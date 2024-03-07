function [Q] = setQ(iter,Npoints, x_toa, y_toa)
%step 1, 2 is ToA(iter,Npoints) -> Initial estimate process

%step 3~ Kalman Filter ( predict by velocity )
%simulate to make Q matrix w = [ w_1; w_2] / w*trans(w) = 2by2 matrix
A = [1 0; 0 1];
pre_x = zeros(iter,Npoints);
pre_y = zeros(iter,Npoints);
kf_pos = [pre_x; pre_y];
% simulate Q matrix
for num1 = 1:iter
    x_vel(num1,1) = x_toa(num1,2) - x_toa(num1,1);
    y_vel(num1,1) = y_toa(num1,2) - y_toa(num1,1);
    velocity(:,1) = [x_vel(num1,1); y_vel(num1,1)];
    pre_x(num1,3) = x_toa(num1,2) + x_vel(num1,1);
    pre_y(num1,3) = y_toa(num1,2) + y_vel(num1,1);
    x_err(num1,1) = pre_x(num1,3) - x_toa(num1,3);
    y_err(num1,1) = pre_y(num1,3) - y_toa(num1,3);
end
w_1 = sum(x_err,"all")/iter;
w_2 = sum(y_err,"all")/iter;
W = [w_1; w_2];

for num1 = 1:iter
    x_vel(num1,1) = x_toa(num1,2) - x_toa(num1,1);
    y_vel(num1,1) = y_toa(num1,2) - y_toa(num1,1);
    velocity(:,1) = [x_vel(num1,1); y_vel(num1,1)];
    pre_x(num1,3) = x_toa(num1,2) + x_vel(num1,1) - w_1;
    pre_y(num1,3) = y_toa(num1,2) + y_vel(num1,1) - w_2;
    x_err(num1,1) = pre_x(num1,3) - x_toa(num1,3);
    y_err(num1,1) = pre_y(num1,3) - y_toa(num1,3);
end
w_1 = sum(x_err,"all")/iter;
w_2 = sum(y_err,"all")/iter;
W = [w_1; w_2];
Q = W*W';


end