function out = GAmat2string(matrix)

%GAMAT2STRING(M) transforms from an array to string representation
%
% Version: 1.0 (Nov, 2010)
% Copyright (c) 2010, Aragon-Camarasa, G., Aragon-Gonzalez, G.;
% Aragon J. L. & Rodriguez-Andrade, M. A.


% Simplify matrix
matrix = simplifyResult(matrix);


sizMat = size(matrix);
str = [];
mat = cell(1,sizMat(1));
for i = 1:sizMat(1)
    
    vec = matrix(i,:);
    sumVec = sum(abs(vec)>0,2);
    
    if sumVec == 1 % Scalar or 1-blade
        idx = find(vec); % Extract basis
        coeff = vec(idx); % Extract coeff
        if idx == 1 % Scalar case
            strTemp = num2str(coeff);
        else % 1-blade case
            if abs(coeff) - eps ~= 1.0
                strTemp = [num2str(coeff) 'e' num2str(idx-1)];
            else
                if coeff < 0
                    strTemp = ['-e' num2str(idx-1)];
                else
                    strTemp = ['e' num2str(idx-1)];
                end
            end
        end
    end
    
    if sumVec >= 2 % When k-blade (where k >= 2)
        idx = find(vec); % Extract basis
        coeff = vec(idx(1)); % Extract coeff
        if coeff >= 0 && coeff ~= 1
            strTemp = num2str(coeff);
        else
            if coeff < -eps && coeff ~= -1
                strTemp = num2str(coeff);
            elseif coeff == -1
                strTemp = '-';
            else
                strTemp = [];
            end
        end
        for j = 1:length(idx)
            strTemp = [strTemp 'e' num2str(idx(j)-1)]; %#ok<AGROW>
        end
    end
    
    if sumVec > 0
        %str = [str ws strTemp s]; %#ok<*AGROW>
        mat{i} = strTemp;
    end
    
    if sumVec == 0
        str = '0';
    end
end

% idx = findstr(str, '-');
% while ~isempty(idx)
%     if ~isempty(idx)
%         if idx(1) ~= 1
%             str(idx(1)) = [];
%             idx2 = findstr(str, '+');
%             str(idx2(1)) = '-';
%         end
%     end
%     idx3 = findstr(str(idx(1) + 1:end), '-');
%     idx = idx3 + idx(1);
% end

if sumVec ~= 0
    for i = 1:length(mat)
        if strcmp(mat{i}(1), '-') && i > 1
            mat{i} = [' - ', mat{i}(2:end)];
        elseif i > 1
            mat{i} = [' + ', mat{i}];
        end
        str = [str, mat{i}]; %#ok<AGROW>
    end
end

out = str;










