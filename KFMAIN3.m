clear all;
close all;

%data creating
position_variance=[0.001,0.01,0.1,1,10,100];
velocity_variance=0.1;

iter=1e3;
a=0.1*pi;

% When Npoints 10
Npoints = 10;
[measurement0001,measurement001,measurement01,measurement1,measurement10,measurement100] = MD(iter,Npoints);
%kalman filter Algorithm 1
[K0001,theory0001,est0001]=KF3(iter,Npoints,0.001,measurement0001);

%When Npoints 100
Npoints = 100;
[s_measurement0001,s_measurement001,s_measurement01,s_measurement1,s_measurement10,s_measurement100] = MD(iter,Npoints);
%kalman filter Algorithm 2
[s_K0001,s_theory0001,s_est0001]=KF3(iter,Npoints,0.001,s_measurement0001);


