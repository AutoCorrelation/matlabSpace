function [x_update, P_update, K, Q_adaptive, R_adaptive]=adaptiveKalmanFilter(x_prev, P_prev, v, Q, R, z, mean_noise)
    % 시스템 행렬
    F = [1 0; 0 1];
    dt = 0.1;
    
    % 예측 단계
    x_pred = F*x_prev + v*dt + mean_noise;
    P_pred = F*P_prev*F' + Q;
    
    % 혁신 시퀀스 계산
    innovation = z - x_pred;
    S = P_pred + R;
    
    % 적응형 R 행렬 업데이트
    R_adaptive = innovation*innovation' - P_pred;
    R_adaptive = max(R_adaptive, 0.001*eye(size(R))); % 양의 정부호성 보장
    
    % 적응형 Q 행렬 업데이트
    residual = x_pred - x_prev;
    Q_adaptive = residual*residual' - P_prev;
    Q_adaptive = max(Q_adaptive, 0.001*eye(size(Q))); % 양의 정부호성 보장
    
    % 칼만 게인 계산
    K = P_pred*pinv(S);
    
    % 업데이트 단계
    x_update = x_pred + K*innovation;
    P_update = (eye(2) - K)*P_pred;
end