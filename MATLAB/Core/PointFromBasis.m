function out = PointFromBasis(x, n)

%POINTFROMBASIS(X,N) converts the Clifford Algebra element x (a point)
% of dimension n to the standard Mathematica form {a,b,...}.
%
% Author by: Charles Gunn, 03/2011
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

out = ToVector(Dualize(x, n), n);