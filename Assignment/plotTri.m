function triResult = plotTri(t, s, shift, plotOnOff)
    n = length(t);
    triResult = zeros(1, n);

    for iter = 1:n

        if (t(1, iter) >= -1 / s + shift && t(1, iter) <= 0 + shift)
            triResult(1, iter) = s * (t(1, iter) - shift) + 1; %기울기가 scale인
        end

        if (t(1, iter) <= 1 / s + shift && t(1, iter) > 0 + shift)
            triResult(1, iter) = -s * (t(1, iter) - shift) + 1; %기울기가 -scale인
        end

    end

    if plotOnOff == 1
        figure(5);
        plot(t, triResult);
        title("tri(t)");
        grid on
    end

end
