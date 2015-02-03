function out = HomogeneousQ(x, r)

%HOMOGENEOUSQ(X,R) gives True if x is a r-blade and False otherwise.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ~isnumeric(r)
    error('r must be numeric');
end
if ischar(x)
    x = GAstring2mat(x);
end

len_x = numel(x);
x = simplifyResult(x);

grd = Grade(x,r);

test = 0;
if numel(grd) == len_x
    test = x == grd;
end

out = false;
if sum(test(:)) == len_x
    out = true;
end