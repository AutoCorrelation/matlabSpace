% 초기화
clear all;
close all;

% Sin(at) 모션 모델에 따른 상태 전이 행렬 A
A = [1 1; 0 1]; % 시간 간격은 1

% 측정값을 사용하는 측정 행렬 H
H = [1 0; 0 1];

% 데이터 생성 (sin 함수 따라 움직이는 2차원 위치 데이터)
a = 0.1; % sin 함수의 주파수
n_points = 50; % 데이터 포인트 수
t = linspace(0, 10, n_points);
true_positions = [sin(a*t); a*cos(a*t)];

% 초기 상태 추정 값
initial_state = [0; 0];

% 반복 횟수 설정
num_iterations = 10;

% 반복 실행 및 결과 저장
all_estimated_states = cell(1, num_iterations);
for i = 1:num_iterations
    % 노이즈 추가하여 측정값 생성
    position_variance = 0.1; % 위치 분산
    velocity_variance = 0.01; % 속도 분산
    noise = [position_variance * randn(1, n_points); velocity_variance * randn(1, n_points)];
    measurements = true_positions + noise;

    % 칼만 필터 실행
    estimated_states = run_kalman_filter(A, H, measurements, initial_state);
    all_estimated_states{i} = estimated_states;
end

% 결과 시각화
figure;
hold on;
plot(t, true_positions(1, :), 'g', 'LineWidth', 2);
plot(t, measurements(1, :), 'b.', 'MarkerSize', 10);
for i = 1:num_iterations
    plot(t, all_estimated_states{i}(1, :), 'r', 'LineWidth', 1);
end
xlabel('Time');
ylabel('Position');
legend('True Position', 'Measurements', 'Estimated Position');
title('Position Estimation using Kalman Filter');

% run_kalman_filter.m 파일과 함께 사용되어야 하는 함수 파일을 생성하세요.
