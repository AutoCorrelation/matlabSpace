clear

M = 1e4; %발생 점 갯수
rho = 0; %-1, 0 ,1
for i=1:M
    y(i)=randn;
    mx=rho*y(i);
    sigma_x=sqrt(1-rho^2);
    x(i)=sigma_x*randn+mx;
end

plot(x,y,'b.')
grid on;