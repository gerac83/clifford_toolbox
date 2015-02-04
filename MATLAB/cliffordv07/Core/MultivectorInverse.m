function out = MultivectorInverse(in)

%MULTIVECTORINVERSE(A) gives the inverse of a multivector defined in 'in'
% See GeometricProduct for input and output formats.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ischar(in)
    in = GAstring2mat(in);
end
inT = Turn(in);
temp = GeometricProduct(in, inT);
if size(temp,2) > 1
    if sum(temp(2:end),2) > 0
        error('Inverse does not exist!');
    end
end
out = inT ./ temp(1);