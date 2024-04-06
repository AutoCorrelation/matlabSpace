function [jVal, w] = gradientDescentStep(w)
    global X;

    for i = 1:100
        % code to compute hx
        alpha = 0.1;
        hx_temp = X * w;
        hx = 1 ./ (1 + exp(-hx_temp));
        lambda = 0.1;
        y= X;
        % code to comput J(w)
        jVal = ((-y' * log(hx) - (1 - y') * log(1 - hx)) - lambda / 2 * sum(w .^ 2)) / size(X, 1);

        %code to update parameter w_0
        w(1) = w(1) - (alpha / size(X, 1) * sum(hx - y,"all"));
        %code to update parameter w_1
        w(2) = w(2) * (1 - (alpha * lambda / size(X, 1))) - (alpha / size(X, 1) * sum((hx - y) .* X(:, 2),"all"));
    end

end
