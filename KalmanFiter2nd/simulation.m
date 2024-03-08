function [Q,P_0] = simulation(iter,Npoints, x_toa, y_toa)
%step 1, 2 is ToA(iter,Npoints) -> Initial estimate process

%step 3~ Kalman Filter ( predict by velocity )
%simulate to make Q matrix w = [ w_1; w_2] / w*trans(w) = 2by2 matrix
A = [1 0; 0 1];
pre_x = zeros(iter,Npoints-2);
pre_y = zeros(iter,Npoints-2);

% simulate Q matrix
for num1 = 1:iter
    x_vel(num1,1) = x_toa(num1,2) - x_toa(num1,1);
    y_vel(num1,1) = y_toa(num1,2) - y_toa(num1,1);
    % velocity(:,1) = [x_vel(num1,1); y_vel(num1,1)]; 필요없는 듯?
    pre_x(num1,1) = x_toa(num1,2) + x_vel(num1,1);
    pre_y(num1,1) = y_toa(num1,2) + y_vel(num1,1);
    x_err(num1,1) = pre_x(num1,1) - x_toa(num1,3);
    y_err(num1,1) = pre_y(num1,1) - y_toa(num1,3);

    % 실제위치 2,2를 안다고 가정하고 오차공분산 초기값 시뮬레이션
    x_theory_err(num1,1) =  2 - x_toa(num1,2);
    y_theory_err(num1,1) =  2 - y_toa(num1,2);
end
%simulation을 통해 얻은 오메가 (Wk-1)
w_1 = sum(x_err,"all")/iter;
w_2 = sum(y_err,"all")/iter;  

% bias_x = sum(x_theory_err,"all")/iter;
% bias_y = sum(y_theory_err,"all")/iter;
% 
% for num1 = 1:iter
%     x_vel(num1,1) = x_toa(num1,2) - x_toa(num1,1);
%     y_vel(num1,1) = y_toa(num1,2) - y_toa(num1,1);
%     % velocity(:,1) = [x_vel(num1,1); y_vel(num1,1)]; 필요없는 듯?
%     pre_x(num1,1) = x_toa(num1,2) + x_vel(num1,1) - w_1;
%     pre_y(num1,1) = y_toa(num1,2) + y_vel(num1,1) - w_2;
%     x_err(num1,1) = pre_x(num1,1) - x_toa(num1,3);
%     y_err(num1,1) = pre_y(num1,1) - y_toa(num1,3);
% end
% w_1 = sum(x_err,"all")/iter;
% w_2 = sum(y_err,"all")/iter;

Px_0 = sum(x_theory_err,"all")/iter;
Py_0 = sum(y_theory_err,"all")/iter;
simulated_W = [w_1; w_2];  % system equation term.
P_0 = [Px_0;Py_0];

simulated_Q = simulated_W*simulated_W';
Q = simulated_Q -simulated_W 



end