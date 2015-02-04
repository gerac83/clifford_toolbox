function out = Grade(A, k)

%GRADE(A) gives the grade value of all components in the multivector
%GRADE(A,R) gives the r-vector part of the multivector m.
%
% INPUTS
% A should be either a matrix or a string as defined in GAproduct. 'k'
% denotes the r-vector part needed. If 'k' is not defined, a list of the
% grade for each component is returned.
%
% OUTPUTS
% If A is a matrix, the output in 'out' is a matrix.
% If A is a string and 'k' is not defined, the output is a list with the
% grades of each component in the vector. Otherwise, it returns a string
% with the r-vector component. 
%
% EXAMPLE
%
%   A = '5e5+e6e9+e3e4e5e6+e1e2e3+e3';
%   Grade(A, 2)
%
%   ans = e6e9
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

flag = 0;
if ischar(A)
    A = GAstring2mat(A);
    flag = 1;
end

sumScalar = sum(abs(A(:,1) > 0),2);
sumIn = sum(abs(A(:,2:end)) > 0,2);

if nargin < 2
    out = sumIn;
else
    if k == 0
        idx = sumScalar == 1;
        out = A(idx,:);
        if size(out,2) > 1
            out(:,2:end) = 0;
        end
    else
        idx = sumIn == k;
        out = A(idx,:);
        if isempty(out)
            out = zeros(size(A));
        end
    end
end

if flag && nargin > 1
    out = GAmat2string(out);
end
    