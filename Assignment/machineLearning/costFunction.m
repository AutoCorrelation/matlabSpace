function [jVal, gradient] = costFunction(w)
jVal = (w(1)-5)^2 + (w(2)-3)^2;
gradient = zeros(2,1);
gradient(1) = 2*(w(1)-5);
gradient(2) = 2*(w(2)-3);
end