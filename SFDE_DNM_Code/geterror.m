function [Error_prediction] = geterror(out,target)

J=length(target);
for j=1:J
    Error(j)=(out(j)-target(j))^2;
end
Error_prediction=1/J*sum(Error);