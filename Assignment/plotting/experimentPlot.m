clear
close all
clc
format long

hold on
grid on
rc = [15/(0.51 ) 0;15/(0.68 ) 0;15/(1.0 ) 0;15/(1.2 ) 0;15/(1.8 ) 0;15/(2.4) 0];
Vcc = [0 15;0 15;0 15;0 15;0 15;0 15];
%시뮬레이션 값
simuled_Icq = [10.07 9.608 8.865 8.465 7.481 6.194];
simuled_Vceq = [9.866 8.467 6.135 4.842 1.535 0.134];
%실험 결과 값
measured_Icq = [
    19.4
    17.4
    14.3
    12.3
    8.28
    6.28
    ];
measured_Vceq = [
    5.1
    3.15
    0.645
    0.220
    0.103
    0.069
    ];
for num1 = 1:length(rc)
    p=plot(Vcc (num1,:),rc(num1,:),'b:');
end

plot(simuled_Vceq,simuled_Icq,'-squre');
plot(measured_Vceq,measured_Icq,'-o');
legend('R=0.51ohm','R=0.68ohm','R=1.0ohm','R=1.2ohm','R=1.8ohm','R=2.4ohm',...
    'simuled Data','measured Data');
xlabel('V_D_S [V]');
ylabel('I_D [mA]');

