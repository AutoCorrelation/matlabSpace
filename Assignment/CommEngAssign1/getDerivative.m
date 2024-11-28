function output = getDerivative(input,Ts)
    output = zeros(size(input));
    for i = 1:length(input)-1
        output(i) = (input(i+1) - input(i)) / Ts;
    end
end