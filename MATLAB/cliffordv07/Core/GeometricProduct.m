function [out, out1] = GeometricProduct(varargin)

%GEOMETRICPRODUCT(A1,A2,...) calculates the geometric product of
% multivectors m1,m2,..., mn
%
% INPUTS
% Inputs may be a string or a matrix. They are explained below...
% STRING: it should be expresed in terms of the geometric algrabra basis.
% See example below.   
% MATRIX: it should be a matrix like: [scalar, e1, e2, e3, ..., en; ....]
% such that for each row denotes addition. Thus, writting:
% A = 2 + e1 + 4e2e3 + 8e1e2e5 shoud be
%
%   A = [2, 0, 0, 0, 0, 0;
%        0, 1, 0, 0, 0, 0;
%        0, 0, 4, 4, 0, 0;
%        0, 8, 8, 0, 0, 8];
%
%
% OUTPUTS
% Two different outputs are available, a matrix or a string representation.
% The former is by default whereas the latter is invoke by defining a
% second ouput in the function. For example:
%
%   out = GeometricProduct(...) -> Matrix representation
%   [out, out1] = GeometricProduct(...) -> Matrix and string representation
%                                   accordingly
%
% Examples.
%
%   MATRIX REPRESENTATION
%   A = [0, 1];
%   B = [0, 7, 7, 0; 0, 1, 1, 1];
%   MAT = GeometricProduct(A,B)
%
%   MAT = [0     0     7     0;
%          0     0     1     1];
%
%   STRING REPRESENTATION
%   A = 'e1';
%   B = '7e1e2 + e1e2e3';
%   [MAT, STR] = GeometricProduct(A,B)
%
%   STR = '7e2 + e2e3'
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.;
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
    
    % Check that both has the same number of columns (dimensions)
    [A, B, sizA, sizB] = setDimensions(A, B,  size(A), size(B));
    
    % Set output matrix
    out = zeros(sizA(1)*sizB(1),sizA(2));
    k = 1;
    for i = 1:sizA(1)
        for j = 1:sizB(1)
            % Coefficients
            tupleA = abs(A(i,:)) > 0; tupleB = abs(B(j,:)) > 0;
            coeff1 = A(i,tupleA); coeff2 = B(j,tupleB);
            if isempty(coeff1)
                coeff1 = 0;
            end
            if isempty(coeff2)
                coeff2 = 0;
            end
            coeff = coeff1(1) * coeff2(1);
            
            % Product of 2 blades
            gp = prodTwoBlades(tupleA, tupleB);
            
            % Multiply and append it to the output matrix
            out(k,:) = coeff * gp;
            k = k + 1;
        end
    end
    
    out = simplifyResult(out);
end

if nargout > 1
    out1 = GAmat2string(out);
end

% Geometric function of two blades (Vahlen 1897)
function gp = prodTwoBlades(nx, ny)

global signature;

if isempty(signature)
    Set_Signature; % Set default
end

s = 0;
for m = 2:size(nx,2) - 1 % First element in the list is the scalar
    for n = m+1:size(ny,2)
        s = s + (ny(m) * nx(n));
    end
end

% ******Before bilinearform
% scalar = bsxfun(@and, nx(1), ny(1));
% res = bsxfun(@xor, nx(2:end), ny(2:end));
% *************************

scalar = bsxfun(@and, nx(1), ny(1));
res = bsxfun(@xor, nx(2:end), ny(2:end));
idx = find((nx(2:end) + ny(2:end)) > 1);

if sum(res) < 1
    scalar = 1;
end

gp = ((-1)^s) * [scalar, res];
if ~isempty(idx)
    for i = 1:length(idx)
        bf = bilinearform(idx(i));
        gp = bf*gp;
    end
end





