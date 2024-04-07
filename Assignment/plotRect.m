function rectResult = plotRect(t, s, shift, plotOnOff)
    n = length(t);
    rectResult = zeros(1, n);

    for iter = 1:n

        if (t(iter) >= -0.5 / s + shift && t(1, iter) <= 0.5 / s + shift)
            rectResult(1, iter) = 1;
        end

    end

    if plotOnOff == 1
        figure(4);
        plot(t, rectResult);
        title(sprintf("Rect(%g *t + %g)", s, shift));
        grid on
    end

end
