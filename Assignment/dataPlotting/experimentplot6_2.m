clear
close all
clc
format long

hold on
grid on
rc = [15/(0.3+2) 0;15/(0.51+2) 0;15/(0.68+2) 0;15/(1.0+2) 0;15/(1.2+2) 0;15/(1.8+2) 0];
Vcc = [0 15;0 15;0 15;0 15;0 15;0 15];
%시뮬레이션 값
simuled_Icq = [3.722 2.289 1.749 1.214 1.020 0.690];
simuled_Vceq = [6.439 9.253 10.311 11.357 11.738 12.38];
%실험 결과 값
measured_Icq = [
    3.79
    2.30
    1.7
    1.25
    1.01
    0.71

    ];
measured_Vceq = [
    6.30
    9.23
    10.42
    11.25
    11.73
    12.29
    ];
for num1 = 1:length(rc)
    p=plot(Vcc (num1,:),rc(num1,:),'b:');
end
p.Color = '#00841a';
plot(simuled_Vceq,simuled_Icq,'-squre');
plot(measured_Vceq,measured_Icq,'-o');
legend('R=0.30ohm','R=0.51ohm','R=0.68ohm','R=1.0ohm','R=1.2ohm','R=1.8ohm',...
    'simuled Data','measured Data');
xlabel('V_D_S [V]');
ylabel('I_D [mA]');

