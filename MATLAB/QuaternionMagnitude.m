function out = QuaternionMagnitude(q)

%QUATERNIONMAGNITUDE(Q) gives the magnitude of a quaternion q.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

q = transform(q);
qM = Magnitude(q);
out = untransform(qM);