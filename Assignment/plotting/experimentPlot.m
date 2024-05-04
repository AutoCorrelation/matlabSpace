clear
close all
clc
format long

hold on
grid on
rc = [ 10/0.47 0;10/1.0 0;10/1.2 0;10/1.8 0;10/2.4 0;10/2.7 0];
Vcc = [0 10;0 10;0 10;0 10;0 10;0 10;];
%시뮬레이션 값
simuled_Icq = [0 3.639 4.084 4.602 4.733 4.779 4.903];
simuled_Vceq = [0 0.1760 0.1974 1.717 4.320 5.222 7.695];
%실험 결과 값
measured_Icq = [0 3.630 4.122 4.987 5.102 5.183 5.222];
measured_Vceq = [0 0.155 0.171 0.983 3.876 4.93 7.53];
for num1 = 1:6
    p=plot(Vcc (num1,:),rc(num1,:),'b:');
end
p.Color = '#00841a';
plot(simuled_Vceq,simuled_Icq,'squre-','LineWidth',1.3);
plot(measured_Vceq,measured_Icq,'o-','LineWidth',1.3);
legend('R=0.47ohm','R=1.0ohm','R=1.2ohm','R=1.8ohm',...
'R=2.4ohm','R=2.8ohm','simuled Data','measured Data');
xlabel('V_C_E [V]');
ylabel('I_C [mA]');

