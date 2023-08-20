clear all;
close all;

%data creating
position_variance=[0.001,0.01,0.1,1,10,100];
velocity_variance=0.1;

iter=5;

a=0.1*pi;
Npoints = 10;
t = linspace(0, 10, Npoints);
true_state = [sin(a*t);a*cos(a*t)];
%plot(t,true_position);
initial_state=[0; a*cos(0)];

for i=1:iter
    for j=1:Npoints
        measurement0001=true_state+[position_variance(1,1)*randn(1,Npoints);velocity_variance*randn(1,Npoints)];
        measurement001=true_state+[position_variance(1,2)*randn(1,Npoints);velocity_variance*randn(1,Npoints)];
        measurement01=true_state+[position_variance(1,3)*randn(1,Npoints);velocity_variance*randn(1,Npoints)];
        measurement1=true_state+[position_variance(1,4)*randn(1,Npoints);velocity_variance*randn(1,Npoints)];
        measurement10=true_state+[position_variance(1,5)*randn(1,Npoints);velocity_variance*randn(1,Npoints)];
        measurement100=true_state+[position_variance(1,6)*randn(1,Npoints);velocity_variance*randn(1,Npoints)];
        
        [estimated_state0001,error_est0001,error_theory0001]=KF(Npoints,initial_state,true_state,measurement0001,0.001);
        [estimated_state001,error_est001,error_theory001]=KF(Npoints,initial_state,true_state,measurement001,0.01);
        [estimated_state01,error_est01,error_theory01]=KF(Npoints,initial_state,true_state,measurement01,0.1);
        [estimated_state1,error_est1,error_theory1]=KF(Npoints,initial_state,true_state,measurement1,1);
        [estimated_state10,error_est10,error_theory10]=KF(Npoints,initial_state,true_state,measurement10,10);
        [estimated_state100,error_est100,error_theory100]=KF(Npoints,initial_state,true_state,measurement100,100);
        err_est{i}=[error_est0001, error_est001, error_est01, error_est1, error_est10, error_est100];
        err_theory{i}=[error_theory0001 error_theory001 error_theory01 error_theory1 error_theory10 error_theory100];
        
        all_estimated_state0001{i}=estimated_state0001;
        all_estimated_state001{i}=estimated_state001;
        all_estimated_state01{i}=estimated_state01;
        all_estimated_state1{i}=estimated_state1;
        all_estimated_state10{i}=estimated_state10;
        all_estimated_state100{i}=estimated_state100;
    end
end

figure;
hold on;
plot(t, true_state(1, :), 'g', 'LineWidth', 2);
plot(t, measurement1(1, :), 'b.', 'MarkerSize', 10);
plot(t, all_estimated_state1{2}(1, :), 'r', 'LineWidth', 1);
xlabel('Time');
ylabel('Position');
legend('True Position', 'Measurements', 'Estimated Position');
title('Position Estimation using Kalman Filter');
hold off
figure;
semilogx(position_variance,err_est{:,1}(1,:),"b");
grid on
hold on
semilogx(position_variance,err_theory{:,1}(1,:),"r");
xlabel('Time');
ylabel('err');
legend('est', 'theory');
title('comparing err each variance using Kalman Filter');

