function[measurement0001,measurement001,measurement01,measurement1,measurement10,measurement100] = MD(iter, Npoints)
velocity_variance=0.1;

a=0.1*pi;
t = linspace(0, 10, Npoints);
true_state = [10*sin(a*t);10*a*cos(a*t)];
position_variance=0.001;

for i=1:iter
    for j=1:Npoints
        
        measurement0001{i}=true_state+[position_variance*randn(1);velocity_variance*randn(1)];
    end
end

position_variance=0.01;
for i=1:iter
    for j=1:Npoints
        
        measurement001{i}=true_state+[position_variance*randn(1);velocity_variance*randn(1)];
    end
end

position_variance=0.1;
for i=1:iter
    for j=1:Npoints
        
        measurement01{i}=true_state+[position_variance*randn(1);velocity_variance*randn(1)];
    end
end

position_variance=1;
for i=1:iter
    for j=1:Npoints
        
        measurement1{i}=true_state+[position_variance*randn(1);velocity_variance*randn(1)];
    end
end

position_variance=10;
for i=1:iter
    for j=1:Npoints
        
        measurement10{i}=true_state+[position_variance*randn(1);velocity_variance*randn(1)];
    end
end

position_variance=100;
for i=1:iter
    for j=1:Npoints
        
        measurement100{i}=true_state+[position_variance*randn(1);velocity_variance*randn(1)];
    end
end