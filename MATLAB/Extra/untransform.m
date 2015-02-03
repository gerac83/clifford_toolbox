function out = untransform(in)

%UNTRANSFORM(IN) untransforms IN from Clifford algebra to quaternion
% representation
%
% Version: 1.0 (Nov, 2010)
% Copyright (c) 2010, Aragon-Camarasa, G., Aragon-Gonzalez, G.;
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ischar(in)
    in = GAstring2mat(in);
end

tuples = cell(size(in,1),1);
for i = 1:size(in,1)
    idx = find(in(i,:));
    tuples{i} = [in(i,idx(1)), tuples{i}, idx - 1];
end

Q = [-1, 2, 3; % I
    1, 1, 3; % J
    -1, 1, 2]; % K

strcell = cell(size(in,1),1);
scalarFlag = 0; % To indicate wether a scalar has been indexed
for i = 1:size(in,1)
    if length(tuples{i}) == 2
        strcell{1} = num2str(tuples{i}(:,1));
        scalarFlag = 1;
    else
        test = sum(Q(:,2:3) == repmat(tuples{i}(:,2:3), 3 ,1),2) == 2; % Find entries of quaternion basis
        idx = find(test, 1);
        if ~isempty(idx)
            temp = (abs(tuples{i}(:,1))/tuples{i}(:,1)) * Q(idx,1);
            if temp == 1; % Test if it's negative
                if abs(tuples{i}(:,1)) ~= 1
                    strcell{idx+scalarFlag} = [num2str(abs(tuples{i}(:,1))), strQ(idx)];
                else
                    strcell{idx+scalarFlag} = strQ(idx);
                end
            else
                if abs(tuples{i}(:,1)) ~= 1
                    strcell{idx+scalarFlag} = ['-' num2str(abs(tuples{i}(:,1))), strQ(idx)];
                else
                    strcell{idx+scalarFlag} = ['-' strQ(idx)];
                end
            end
        end
    end
end

strcell = strcell(~cellfun('isempty',strcell));
% Create expression
out = [];
for i = 1:length(strcell)
    idx = strfind(strcell{i},'-');
    if isempty(idx) && i ~= 1
        out = [out '+' strcell{i}]; %#ok<*AGROW>
    else % it's negative!!
        out = [out strcell{i}];
    end
end

function out = strQ(in)

switch in
    case 1
        out = 'i';
    case 2
        out = 'j';
    case 3
        out = 'k';
    otherwise
        error('Unknown option in UNTRANSFORM->STRQ');
end

