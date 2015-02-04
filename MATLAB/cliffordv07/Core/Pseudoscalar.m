function out = Pseudoscalar(n,opt)

%PSEUDOSCALAR(N) gives the n-dimensional pseudoscalar.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if nargin < 2
    opt = 0;
end

if ~isnumeric(n)
    error('first input should be numeric!');
end

out = zeros(1,n+1);
out(:,2:end) = 1;

if opt
    out = GAmat2string(out);
end