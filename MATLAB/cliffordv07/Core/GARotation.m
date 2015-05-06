function out = GARotation(v, w, x, theta)

%GAROTATION(V,W,X,THETA) Rotates the vector v by an angle theta
% (in degrees), along the plane defined by w and x. The sense of the
% rotation is from w to x. Default value of theta is the angle between
% w and x.
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

plano=OuterProduct(w,x);

if nargin > 3
    if ~isnumeric(theta)
        error('THETA must be numeric and in degrees!');
    end
    theta = deg2rad(theta);
    r = sin(theta/2) * (plano / Magnitude(plano));
    r = GAarithmetic('plus', cos(theta/2), r);
else
    [w, x] = setDimensions(w, x,  size(w), size(x));
    theta = InnerProduct(w,x)/(Magnitude(w)*Magnitude(x));
    theta = theta(1);
    r = sqrt((1-theta)/2) * (plano / Magnitude(plano));
    r = GAarithmetic('plus', sqrt((1+theta)/2), r);
end

out = GeometricProduct(Turn(r),v,r);
if flag
    out = GAmat2string(out);
end

