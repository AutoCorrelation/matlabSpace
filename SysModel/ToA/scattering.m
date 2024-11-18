% 데이터 준비
data1 = [1.503 3.288 4.20 3.96 4.6 6.650 8.6 6.3 9.53 10.15];
data2 = [1 1.785 0.92 0 0.6 2 2 -2 2.8 0.6];

% 데이터 표준화
data1_standardized = (data1 - mean(data1)) / std(data1);
data2_standardized = (data2 - mean(data2)) / std(data2);

% 상관계수 계산
R = corrcoef(data1_standardized, data2_standardized);

% 상관계수 출력
disp('상관계수:');
disp(R);

% 산점도 그리기
figure;
scatter(data1_standardized, data2_standardized);
title('Scatter Plot of Standardized data1 and data2');
xlabel('Standardized data1');
ylabel('Standardized data2');
grid on;
