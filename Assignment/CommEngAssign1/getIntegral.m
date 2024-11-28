function output = getIntegral(input,Ts)
    output = zeros(size(input));
    for i = 2:length(input)
        output(i) = output(i-1) + input(i) * Ts;
    end
end