clear
close all
clc
format long

hold on
grid on
rc = [10/(0.2+1.8) 0;10/(0.47+1.8) 0;10/(0.68+1.8) 0;10/(1.0+1.8) 0;10/(1.8+1.8) 0];
Vcc = [0 10;0 10;0 10;0 10;0 10];
%시뮬레이션 값
simuled_Icq = [4.908 2.959 2.199 1.583 0.935];
simuled_Vceq = [0.177 3.275 4.539 5.558 6.622];
%실험 결과 값
measured_Icq = [4.862 3.119 2.315 1.680 0.975];
measured_Vceq = [0.168 2.891 4.236 5.297 6.471];
for num1 = 1:5
    p=plot(Vcc (num1,:),rc(num1,:),'b:');
end
p.Color = '#00841a';
plot(simuled_Vceq,simuled_Icq,'squre');
plot(measured_Vceq,measured_Icq,'o');
legend('R=0.20ohm','R=0.47ohm','R=1.0ohm','R=1.2ohm','R=1.8ohm',...
'simuled Data','measured Data');
xlabel('V_C_E [V]');
ylabel('I_C [mA]');

