function Set_Signature(p, q, s)

%SET_SIGNATURE(P,Q,S) sets the indices (p,q,s) of the bilinear form
% used to define the Clifford Algebra (s is the index of degeneracy). Thus
% it is assumed that for i>p+q+s we have GeometricProduct(ei,ei)=0.
% The default value is [20,0,0]. Once changed, it can be recovered by
% invoking again "Set_Signature;".
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if nargin < 1 % Set defaults
    p = 20;
    q = 0;
    s = 0;
end
if nargin < 2
    q = 0;
    s = 0;
end
if nargin < 3
    s = 0;
end

global signature
signature = [p, q, s];