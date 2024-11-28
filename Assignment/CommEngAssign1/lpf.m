function output = lpf(input,Bw,df)
    output = zeros(size(input));
    centre = ceil((length(input)+1)/2);
    for i = floor(centre-Bw/df):ceil(centre+Bw/df)
        output(i) = input(i);
    end
end