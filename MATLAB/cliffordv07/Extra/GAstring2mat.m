function out = GAstring2mat(str)

%GASTRING2MAT(STRING) transforms from a string to an array
%representation
%
% Version: 1.0 (Nov, 2010)
% Copyright (c) 2010, Aragon-Camarasa, G., Aragon-Gonzalez, G.;
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ~ischar(str)
    error('Input must be a string!');
end

% Eliminate the spaces first
str(strfind(str,' ')) = [];

% Seperate each vector component in MATLAB cells
idx1 = strfind(str, '+');
idx2 = -strfind(str, '-');
idx = [idx1 idx2];
[~, ix] = sort(abs(idx));
idx = idx(ix);
temp = cell(length(idx)+1,1);
i = 1;
sign = [];
while ~isempty(str)
    if isempty(idx)
        temp{i} = [sign str(1:end)];
        str = [];
        i = i+1;
    else
        if abs(idx(1)) == 1
            sign = '-';
            str(1:abs(idx(1))) = [];
            
            idx1 = strfind(str, '+');
            idx2 = -strfind(str, '-');
            idx = [idx1 idx2];
            [~, ix] = sort(abs(idx));
            idx = idx(ix);
        else
            temp{i} = [sign str(1:abs(idx(1))-1)];
            str(1:abs(idx(1))) = [];
            
            if idx(1) < 0
                sign = '-';
            else
                sign = [];
            end
            
            idx1 = strfind(str, '+');
            idx2 = -strfind(str, '-');
            idx = [idx1 idx2];
            [~, ix] = sort(abs(idx));
            idx = idx(ix);
            
            i = i+1;
        end
    end
end
temp = temp(~cellfun('isempty',temp));

% Create matrix of GA elements
matrix = cell(length(temp),1);
maxDim = 0;
for i = 1:length(matrix)
    % Find the grade of each component    
    idx = strfind(temp{i}, 'e');
    if isempty(idx) %Scalar case, no basis
        matrix{i} = zeros(1,2); % Set the entry as 1-blade
        matrix{i}(1) = str2double(temp{i}); % Extract coefficient
        matrix{i}(2) = 1; % Set type of blade (MATLAB indeces work from 1 to N, so zeros it's not possible)
        maxDim = findMaxDimension(maxDim, matrix{i}(2:end));
    else
        matrix{i} = zeros(1, size(idx,2)); % Set the entry according to the type of the blade
        % If 'e' is the first entry, there's not a coefficient defined;
        % therefore it is multiply by one. Also, If first entry in temp{i}
        % is '-', set coeffcient to -1
        if idx(1) == 1 || strcmp(temp{i}(1),'-')
            ix = strfind(temp{i}, 'e');
            if ix(1) ~= 1
                if strcmp(temp{i}(1),'-') && strcmp(temp{i}(2),'e')
                    matrix{i}(1) = -1;
                else
                    matrix{i}(1) = str2double(temp{i}(1:idx(1)-1));
                end
            elseif ix(1) == 1
                matrix{i}(1) = 1;
            end
        else % otherwise
            matrix{i}(1) = str2double(temp{i}(1:idx(1)-1));
        end
        
        j = 2;
        while ~isempty(idx) % For each entry in idx, iterate and extract the dimension of the basis
            if length(idx) == 1
                matrix{i}(j) = str2double(temp{i}(idx(1)+1:end)) + 1; % Set type of blade and add one (MATLAB indeces work from 1 to N, so zeros it's not possible)
                temp{i}(idx(1):end) = []; % Remove the basis
                idx = [];
            else
                matrix{i}(j) = str2double(temp{i}(idx(1)+1:idx(2)-1)) + 1; % Set type of blade and add one (MATLAB indeces work from 1 to N, so zeros it's not possible)
                temp{i}(idx(1):idx(2)-1) = []; % Remove the basis
                idx = strfind(temp{i}, 'e');
            end
            j = j+1;
        end
        maxDim = findMaxDimension(maxDim, matrix{i}(2:end));
    end
end

out = zeros(size(matrix,1),maxDim);
for i = 1:size(matrix,1)
    coeff = matrix{i}(1);
    idx = matrix{i}(2:end);
    out(i,:) = flipSigns(coeff, idx, out(i,:));
end

out = simplifyResult(out);

% Finds the maximum dimension of the current tuple
function dimension = findMaxDimension(dimension, in)

if dimension < max(in)
    dimension = max(in);
end

% Correct signs of the input vector
function vector = flipSigns(coeff, idx, vector)

sizIn = length(idx);
if sizIn == 1 % When it is a 1-blade, nothing has to be done in this case
    vector(idx) = coeff;
else % When it a k-blade (k >= 2),
    tuples = zeros(sizIn,size(vector,2)); % Create tuples for each individual basis in the same order as the input
    str = []; % Empty string which is later filled up with the Geometric product command
    for i = 1:sizIn % Loop until sizIn creating the GAprod input variables for all the tuples
        tuples(i,idx(i)) = 1;
        str = [str 'tuples(' num2str(i) ',:),']; %#ok<AGROW>
    end
    % Evaluate command and finish
    command = ['GeometricProduct(' str(1:end-1) ')'];
    vector = eval(command);
    vector = coeff .* vector;
end







