function fusionResult = fusionRecTri(t, s1, s2)
    n = length(t);
    fusionResult = zeros(1, n);

    % v1=plotRect(t, s1, -3, 0);
    % v2=plotTri(t, s2, -2, 0);
    % v3=plotRect(t, s1, 0, 0);
    fusionResult =plotRect(t, s1, -4, 0)+plotTri(t, s2, -2, 0)+plotRect(t, s1, 0, 0)+plotTri(t, s2, 2, 0)+plotRect(t, s1, 4, 0);

    figure(7);
    plot(t, fusionResult);
    title("3)")
    grid on
end
