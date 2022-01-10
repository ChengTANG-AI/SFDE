function X = boundConstraint (X, Xmin,Xmax)

% if the boundary constraint is violated, set the value to be the middle
% of the previous value and the bound
%
% Version: 1.1   Date: 11/20/2007
% Written by Jingqiao Zhang, jingqiao@gmail.com

[NP, D] = size(X);  % the population size and the problem's dimension

xl = repmat(Xmin, NP, D);
xu = repmat(Xmax, NP, D);
ranX=rand(NP, D);
%% check the lower bound
pos = X < xl;
X(pos) = (xu(pos) - xl(pos)).*ranX(pos);

%% check the upper bound
pos = X > xu;
X(pos) = (xu(pos) - xl(pos)).*ranX(pos);
end