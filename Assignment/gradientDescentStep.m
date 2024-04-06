function [jVal, new_w] = gradientDescentStep(X,w)
    % code to compute hx
    hx_temp = X * w;
    hx = 1 ./ (1 + exp(-hx_temp));
    % code to comput J(w)
    jVal = ((-y' * log(hx) - (1 - y') * log(1 - hx)) - lambda / 2 * sum(w .^ 2)) / size(X, 1);

    %code to update parameter w_0
    new_w(1) = w(1) - (alpha / size(X, 1) * sum(hx - y));
    %code to update parameter w_1
    new_w(2) = w(2) * (1 - (alpha * lambda / size(X, 1))) - (alpha / size(X, 1) * sum((hx - y) .* X(:, 2)));
end
