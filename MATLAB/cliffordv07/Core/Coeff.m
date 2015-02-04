function out = Coeff(m, b)

%COEFF(M,B) gives the coefficient of the r-blade b in the multivector m.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ischar(m)
    m = GAstring2mat(m);
end
if ischar(b)
    b = GAstring2mat(b);
else
    error('b has to be a string, e.g. e[1]');
end

m = simplifyResult(m);
cc = Coefficient(m,b);
out = Grade(cc,0);

