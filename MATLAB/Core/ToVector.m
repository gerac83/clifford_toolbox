function out = ToVector(x,n)

%TOVECTOR(X,N) transform the n-dimensional vector x from a*e[1]+b*e[2]+... to
% the standard Mathematica form {a,b,...}. The defaul value of n is the
% highest of all e[i]'s.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ~HomogeneousQ(x, 1)
    error('ToVector function works only with vectors.');
end

if ischar(x)
    x = GAstring2mat(x);
end

aux = dimensions(x);
test = max(aux)-1;
if nargin < 2
    dim = test;
else
    dim = n;
end

out = zeros(dim,1);
for i = 1:dim
    if i <= test
        temp = Coefficient(x, GAstring2mat(['e' num2str(i)]));
        out(i,1) = temp(1,1);
    end
end

function out = dimensions(a)

out = zeros(size(a,1),1);
for i = 1:size(a,1)
    out(i) = find(a(i,:));
end
 
 
 
 