function out = Magnitude(m)

%MAGNITUDE(M) calculates the Magnitude of the multivector m.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

out = sqrt(Grade(GeometricProduct(m, Turn(m)), 0));
out = out(1);