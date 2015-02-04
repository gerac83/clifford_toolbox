function out = Dualize(m, n)

%DUALIZE(M,N) calculates the Dual of the multivector m in a
% n-dimensional space.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ~isnumeric(n) || n < 0
    error('Second argument must be numeric and positive');
end

Set_Signature(n, 0, 0);
out = Dual(m, n);
Set_Signature;





