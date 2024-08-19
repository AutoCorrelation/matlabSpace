function [Q,R] = GramSchmidtOrth(inMat)
% Matrix Orthoginalization Process
%   자세한 설명 위치 oMat = output_Matrix
[M, N] = size(inMat);
v1 = inMat(:,1);
R(1,1) = norm(inMat);
Q(:,1) = v1/R(1,1);
for n=2:min(M,N)
    vn = inMat(:,n);
    R(1:n-1,n) = Q(:,1:n-1)'*vn;
    qn = vn-Q(:,1:n-1)*R(:,n);
    R(n,n)=norm(qn);
    Q(:,n)=qn/R(n,n); %nomalize
end
end