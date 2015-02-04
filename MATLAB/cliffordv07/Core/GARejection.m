function out = GARejection(v, w)

%GAREJECTION(V,W) calculate the rejection of the vector v on the subspace
% defined by the r-blade w.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

flag = 0;
if ischar(v)
    v = GAstring2mat(v);
    flag = 1;
end
if ischar(w)
    w = GAstring2mat(w);
    flag = 1;
end

out = GeometricProduct(OuterProduct(v,w), MultivectorInverse(w));

if flag
    out = GAmat2string(out);
end
