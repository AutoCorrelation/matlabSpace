function y = my_hilbert(x)
% from https://kr.mathworks.com/help/signal/ref/hilbert.html Algorithm.
    N = length(x);
    % Step 1
    X = fft(x);
    % Step 2
    h = zeros(N, 1);
    h(1) = 1;
    h(N/2+1)=1;
    h(2:N/2)=2;
    % Step 3
    Y = X .* h;
    % Step 4
    y = ifft(Y);
end