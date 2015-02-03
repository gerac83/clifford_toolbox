function out = Dual(m, n)

%DUAL(M,N) calculates the Dual of the multivector m in a
% n-dimensional space.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

flag = 0;
if ischar(m)
    m = GAstring2mat(m);
    flag = 1;
end

if ~isnumeric(n)
    error('first input should be numeric!');
end

t = Turn(Pseudoscalar(n));
out = GeometricProduct(m,t);

if flag
    out = GAmat2string(out);
end


