function estimated_states = run_kalman_filter(A, H, measurements, initial_state)
    n_points = size(measurements, 2);
    estimated_states = zeros(size(initial_state, 1), n_points);
    state = initial_state;
    P = eye(size(initial_state, 1));
    position_variance = 0.1; % 위치 분산
    velocity_variance = 0.01; % 속도 분산
    
    for t = 1:n_points
        % 예측 단계
        x_hat_minus = A * state;
        P_minus = A * P * A' + [position_variance^2 0; 0 velocity_variance^2];
        
        % 업데이트 단계
        K = P_minus * H' / (H * P_minus * H' + [position_variance^2 0; 0 velocity_variance^2]);
        state = x_hat_minus + K * (measurements(:, t) - H * x_hat_minus);
        P = (eye(size(state, 1)) - K * H) * P_minus;
        
        % 결과 저장
        estimated_states(:, t) = state;
    end
end
