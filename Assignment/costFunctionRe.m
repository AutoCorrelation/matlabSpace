function [jVal, gradient] = costFunctionRe(w)
    global X;
    global Y;
    m = size(X, 1);
    n = size(X, 2);
    lambda = 0.1;
    y = X;
    hx_temp = X * w;
    hx = 1 ./ (1 + exp(-hx_temp));
    % code to comput J(w)
    jVal = ((-y' * log(hx) - (1 - y') * log(1 - hx)) - lambda / 2 * sum(w .^ 2)) / m;

    gradient(1) = 1 / m * sum(hx - y, "all");
    gradient(2:n) = 1 / m * (((hx - y)' * X(:, 2:n))' - lambda * w(2:n));
end
