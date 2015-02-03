function C = GAarithmetic(mode, varargin)

if ~ischar(mode)
    error('Use either: "plus" or "minus" as strings in the first argument');
end

if strcmp(mode, 'plus')
    op = 1;
elseif strcmp(mode, 'minus')
    op = -1;
else
    error('Use either: plus or minus');
end

numVar = size(varargin,2);
if numVar < 2
    error('At least two inputs are required');
end

for iter = 1:numVar-1 % Iterate until no input arguments remain
    if iter == 1 % First iteration, assigns the first entry of the arguments
        A = varargin{iter};
    else % otherwise, set as the last output
        A = C;
    end
    B = varargin{iter+1};
    
    if ischar(A)
        A = GAstring2mat(A);
    end
    if ischar(B)
        B = GAstring2mat(B);
    end
    
    % Check that both has the same number of columns (dimensions)
    [A, B] = setDimensions(A, B,  size(A), size(B));
    
    % Subtract
    C = [A; op * B];
    C = simplifyResult(C);
    
end

% Uncomment to output string
%C = GAmat2string(C);
