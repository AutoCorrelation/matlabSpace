function [jVal_s, gradient] = costFunctionRe(w)
global X;
global Y;

m = size(X, 1);
n = size(X, 2);
lambda = 0;
alpha_s = 0.01:0.01:0.09;
y=Y;
% for iter_a=1:9;
    alpha=alpha_s(1);
    for iter = 1:2*1e5;
        hx_temp = X * w;
        hx = 1 ./ (1 + exp(-hx_temp));
        % code to comput J(w)
        jVal = ((-y' * log(hx) - (1 - y') * log(1 - hx)) - lambda / 2 * sum(w .^ 2)) / m;

        gradient(1) = 1 / m * sum(hx - y, "all");
        gradient(2:n) = 1 / m * (((hx - y)' * X(:, 2:n))' - lambda * w(2:n));
        % GPT-4 Code
        % gradient(2:n) = 1 / m * (X(:, 2:n)' * (hx - y) - lambda * w(2:n));
        %code to update parameter w_0
        w(1) = w(1) - (alpha / size(X, 1) * sum(hx - y, "all"));
        %code to update parameter w_1
        w(2:n) = w(2:n) * (1 - (alpha * lambda / size(X, 1))) - (alpha / size(X, 1) * sum((hx - y) .* X(:, 2:n), "all"));
        jVal_s(1,iter) = jVal;
    end
% end

end
