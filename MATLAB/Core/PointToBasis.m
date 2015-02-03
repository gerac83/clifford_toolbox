function out = PointToBasis(vec)

%POINTTOBASIS(VEC) converts a homogenous point into the geometric algebra;
% similar to ToBasis.
%
% Author by: Charles Gunn, 03/2011
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ~isvector(vec)
    error('Input must be a vector.')
end

points = ToBasis(vec);
out = Dualize(points, length(vec));
