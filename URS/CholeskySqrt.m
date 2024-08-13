function [O] = CholeskySqrt(M,n) %M is input Matrix, n is size of M, O is output Matrix
O = zeros(n,n);

for i=1:n
    if i==1
        O(i,i)=sqrt(M(i,i));
    else
        % O(i,i)=sqrt(M(i,i)-sum(O(i,:)*O(i,:),"all")+O(i,i)*O(i,i));
        continue;
    end
    for j=1:n
        if j<i
            continue;
        elseif j==i
            continue;
        else
            % O(j,i)=(M(j,i)-sum(O(j,:)*O(i,:),"all")+O(j,i)*O(i,i))/O(i,i);
            O(j,i)=1;
        end
    end
end
