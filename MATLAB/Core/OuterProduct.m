function [out, out1] = OuterProduct(varargin)

%OUTERPRODUCT(A1,A2,...) calculates the outer product of multivectors
% m1,m2,..., mn
%
% See GeometricProduct for help in this function as it is similar.
%
% NOTE: This function employs the generalised equation in terms of the
% geometric product.
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
        A = varargin{iter};
    else % otherwise, set as the last output
        A = out;
    end
    B = varargin{iter+1};
    
    if ischar(A)
        A = GAstring2mat(A);
    end
    if ischar(B)
        B = GAstring2mat(B);
    end
    
    [A, B, sizA, sizB] = setDimensions(A, B,  size(A), size(B));
    
    % Set output matrix
    out = zeros(sizA(1)*sizB(1),sizA(2));
    k = 1;
    kA = Grade(A);
    kB = Grade(B);
    for i = 1:sizA(1)
        for j = 1:sizB(1)
            p = max(kA(i,:));
            q = max(kB(j,:));
            
            out(k,:) = Grade(GeometricProduct(A(i,:),B(j,:)),p+q);
            k = k + 1;
        end
    end
    
    out = simplifyResult(out);

end

out = simplifyResult(out);

if nargout > 1
    out1 = GAmat2string(out);
else
    %disp(GAmat2string(out))
end