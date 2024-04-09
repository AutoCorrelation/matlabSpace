function plotCos(A, f, phase, t)
    % Variables
    % A = [1, 2, 3];
    % f = [1, 2, 3];
    % phase = [0, pi / 2, -pi / 2];
    % x(t) = A * cos(2 * pi * f * t) + phase);
    %1-a) plot
    figure(1);
    hold on
    grid on

    for v = 1:3
        plot(t, A(1) * cos(2 * pi * f(1) * t + phase(v)));
    end

    title("1-그림 a");
    legend("phase=0", "phase=pi/2", "phase=-pi/2");
    hold off
    %1-b) plot
    figure(2);
    hold on
    grid on

    for v = 1:3
        plot(t, A(1) * cos(2 * pi * f(v) * t) + phase(1));
    end

    title("1-그림 b");
    legend("freq=1", "freq=2", "freq=3");
    hold off

    %1-c) plot
    figure(3)
    hold on
    grid on

    for v = 1:3
        plot(t, A(v) * cos(2 * pi * f(1) * t) + phase(1));
    end

    title("1-그림 c");
    legend("amplitude=1", "amplitude=2", "amplitude=3");
    hold off
end
