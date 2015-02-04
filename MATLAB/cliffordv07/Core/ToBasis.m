function out = ToBasis(x)

%TOBASIS(X) Transform the vector x from {a,b,...} to the  standard form
% used in this Package: a*e[1]+b*e[2]+...."
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

% input checking
if ~isvector(x)
    error('Input must be a vector.')
end
if ~isnumeric(x)
    error('Vector must be numeric!');
end

% Change to row vector
if size(x,1) > 1
    x = x';
end

out = zeros(size(x,2), size(x,2) + 1);
for i = 1:size(x,2)
    tuple = zeros(1,size(x,2));
    tuple(i) = 1;
    out(i,:) = [0, tuple .* x(i)];
end

out = simplifyResult(out);