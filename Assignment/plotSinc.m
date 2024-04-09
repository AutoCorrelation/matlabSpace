function sincResult = plotSinc(t, s, plotOnOff)

    n = length(t);
    sincResult = zeros(1, n);

    for iter = 1:n
        sincResult(1, iter) = sin(s * pi * t(1, iter)) / (s * pi * t(1, iter));
    end

    sincResult(1, ceil(n / 2)) = 1;

    if (plotOnOff == 1)
        figure(6)
        plot(t, sincResult);
        grid on
        title(sprintf("sinc(%g * t)", s));
    end

end
