function output = func_ToA(Z)
% Calculate ToA
persistent H first_run;
if isempty(first_run)
    first_run = 1;
    d1=10;
    d2=d1;
    H = [...
        0, -2*d2
        2*d1, -2*d2
        2*d1, 0
        2*d1, 0
        2*d1, 2*d2
        0, 2*d2];
end
output = pinv(H)*Z;


end