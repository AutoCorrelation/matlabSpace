function dist = anchorMeasure(real_pos, noise_variance)
    persistent first_run Anchor;
    if isempty(first_run)
        first_run = 1;
        d=10;
        Anchor = [0 0 d d; d 0 0 d];
    end
    dist = zeros(4,1);
    for i=1:4
        gap=real_pos-Anchor(:,i);
        dist(i) = sqrt(gap'*gap) + sqrt(noise_variance)*randn;
    end
end