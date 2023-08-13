function[] = KF(iter,NPoints,)

x_h = zeros(1,11);
V = zeros(1,11);
%모델링한 시스템 Matrix
A=[1 T;0 1];
H=[1 0;0 1];
R=[V_kx^2 0;0 V_kv^2];
Q=0;
S_k(iter,NPoints) = [x_h; V];


%초기값 세팅
x_h(0) = 0;
V(0) = 0;

Z_k = H*S_k
