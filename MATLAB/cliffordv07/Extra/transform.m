function out = transform(in)

%TRANSFORM(IN) transforms IN from quaternion to Clifford algebra
% representation
%
% Version: 1.0 (Nov, 2010)
% Copyright (c) 2010, Aragon-Camarasa, G., Aragon-Gonzalez, G.;
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ~ischar(in)
    error('Input must be a string!');
end

idx = strfind(in,' '); % Remove white spaces
in(idx) = [];

% Add find +'s and -'s in order to seperate them in cells
idxP = strfind(in,'+');
idxN = strfind(in,'-');
idx = sort([idxP idxN]);

% Seperate into cells
T = cell(1,1);
i = 1;
while ~isempty(in)
    if idx(1) == 1 && length(idx) > 1
        T{i} = in(1:idx(2) - 1);
        in(1:idx(2) - 1) = [];
        idx = idx - idx(2) + 1;
        idx(1:2) = [];
    elseif idx(1) == 1 && ~(length(idx) > 1)
        T{i} = in(1:end);
        in(1:end) = [];
        idx = [];
    else
        T{i} = in(1:idx(1) - 1);
        in(1:idx(1) - 1) = [];
        idx = idx - idx(1) + 1;
        if length(idx) ~= 1
            idx(1) = [];
        end
    end
    i = i + 1;
end

% Clear +'s
idx = strfind(T, '+');
for i = 1:length(idx)
    if ~isempty(idx)
        T{i}(idx{i}) = [];
    end
end

% Look for i's
idx = strfind(T,'i');
T = processQuaternions(idx, T, '-e2e3');

% Look for j's
idx = strfind(T,'j');
T = processQuaternions(idx, T, 'e1e3');

% Look for k's
idx = strfind(T,'k');
T = processQuaternions(idx, T, '-e1e2');

% Create expression
out = T{1};
for i = 2:length(T)
    idx = strfind(T{i}, '-');
    if isempty(idx)
        out = [out ' + ' T{i}]; %#ok<*AGROW>
    else
        out = [out ' ' T{i}];
    end
end

out = GAstring2mat(out);

function T = processQuaternions(idx, T, bases)

idxSign = strfind(bases, '-');
if ~isempty(idxSign)
    sign = bases(idxSign);
    bases(idxSign) = [];
else
    sign = [];
end

for i = 1:length(idx)
    if ~isempty(idx{i})
        if idx{i} == 1
            T{i} = [];
            T{i} = [sign bases];
        else
            test = T{i};
            idx2 = strfind(test, sign);
            test(idx2) = [];
            if ~isempty(idx2) && length(test) == 1
                T{i} = [];
                T{i} = bases;
            else
                c = T{i}(1:idx{i}-1);
                idx3 = strfind(c, sign);
                c(idx3) = [];
                if isempty(idx3)
                    T{i} = [sign c bases];
                else
                    T{i} = [c bases];
                end
                    
            end
        end
    end
end
