clear
close all
clc
format long

hold on
grid on
RL=[ 1 1.5 2 2.4 3 3.6 4.3];
sim_Av = [
    
    -38.06
    -46.24
    -51.15
    -53.68
    -57.02
    -60.28
    -62.30
    ];
cal_Av = [
    
    -41.9758
    -50.371
    -55.9677
    -59.26
    -62.9637
    -65.7013
    -68.1117
    ];
hold on
grid on
plot(RL,abs(sim_Av),'*-','LineWidth',1,'Color',"r");
plot(RL,abs(cal_Av),'^-','LineWidth',1,'Color',"b");
legend('sim','cal');
xlabel('R_L [㏀]');
ylabel('|A_V| [V/V]');

