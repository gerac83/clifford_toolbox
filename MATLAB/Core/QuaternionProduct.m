function out = QuaternionProduct(varargin)

%QUATERNIONPRODUCT(Q1,Q2,...) gives the product of quaternions q1,q2,...
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

numVar = size(varargin,2);
if numVar < 2
    error('At least two inputs are required');
end

for iter = 1:numVar-1 % Iterate until no input arguments remain
    if iter == 1 % First iteration, assigns the first entry of the arguments
        A = transform(varargin{iter});
    else % otherwise, set as the last output
        A = out;
    end
    B = transform(varargin{iter+1});
    
    if ischar(A)
        A = GAstring2mat(A);
    end
    if ischar(B)
        B = GAstring2mat(B);
    end
    
    out = GeometricProduct(A, B);    
    out = simplifyResult(out);

end

out = simplifyResult(out);
out = untransform(out);

% QuaternionProduct[ _] := $Failed
% QuaternionProduct[q1_,q2_,q3__] := QuaternionProduct[QuaternionProduct[q1,q2],q3]
% QuaternionProduct[q1_,q2_] := untransform[
%                   GeometricProduct[transform[q1],transform[q2]] ]


