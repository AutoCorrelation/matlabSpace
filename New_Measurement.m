function[xh, velocity] = New_Measurement(iter,NPoints,MNV) 

%MNV = 0.001; %measurement Noise Variance
velocity = zeros(NPoints,iter);
xh = zeros(NPoints,iter);
%fileID_velocity=fopen("velocity_data.txt",'w');
%fileID_xh=fopen("xh_data.txt",'w');
for i = 1:iter
    for j = 1:NPoints
        %velocity(j,i) = velocity(j-1,i) + abs((sqrt(MNV)*randn(1)));
        velocity(j,i) = pi/NPoints*cos(pi*(j-1)/NPoints);
        %xh(j,i) = xh(j-1,i) + velocity(j-1,i) + abs((sqrt(MNV)*randn(1))/2);
        xh(j,i)= sin(pi*(j-1)/NPoints);

    end
  %  fpritnf(fileID_velocity,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',velocity(j,1));    
 %   fprintf(fileID_xh,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f \n',xh(j,1));    
end
%fclose(fileID_xh);
%fclose(fileID_velocity);

