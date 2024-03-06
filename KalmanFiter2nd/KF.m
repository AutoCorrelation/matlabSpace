function [outputArg1,outputArg2] = KF(x_toa, y_toa)
%step 1, 2 is ToA -> Initial estimate process
iter = 1e3;
%step 3~ Kalman Filter ( predict by velocity )
%simulate to make Q matrix w = [ w_1; w_2] / w*trans(w) = 2by2 matrix
A = [1 0; 0 1];
% simulate Q matrix
for num1 = 1:iter
    x_vel(num1,1) = x_toa(num1,2) - x_toa(num1,1);
    y_vel(num1,1) = y_toa(num1,2) - y_toa(num1,1);
    x_toa(num1,3) = 
end

end