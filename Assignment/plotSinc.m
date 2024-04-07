function sincResult = plotSinc(t, s)

    n = length(t);
    sincResult = zeros(1, n);

    for iter = 1:n
        sincResult(1, iter) = sin(pi * t(1, iter)) / (pi * t(1, iter));
    end

    figure(6)
    plot(t, sincResult);
    grid on
    title("sinc(t)");
end