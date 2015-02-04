function Set_Epsilon(in)

%SET_SIGNATURE(P,Q,S) sets the machine working precision to be used for
% numerical computations. The default value is "eps". Once changed, it can
% be recovered by invoking again "Set_Epsilon"
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if nargin < 1 % Set defaults
    in = eps;
end

global epsilon
epsilon = in;