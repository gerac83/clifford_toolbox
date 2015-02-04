function out = GAReflection(v, w, x)

%GAREFLECTION(V,W,X) reflects the vector v by the plane formed by the
% vectors w and x.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ~HomogeneousQ(v, 1) || ~HomogeneousQ(w, 1) || ~HomogeneousQ(x, 1)
    error('GARotation function works only with vectors.');
end

flag = 0;
if ischar(v)
    v = GAstring2mat(v);
    flag = 1;
end
if ischar(w)
    w = GAstring2mat(w);
    flag = 1;
end
if ischar(x)
    x = GAstring2mat(x);
    flag = 1;
end

plane = OuterProduct(w,x);
u = Dual(plane/Magnitude(plane),3);
out = GeometricProduct(-u,v,u);

if flag
    out = GAmat2string(out);
end

