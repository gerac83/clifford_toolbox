function out = Turn(m)

%TURN(M) gives the Reverse of the multivector m.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

if ischar(m)
    m = GAstring2mat(m);
end

m = simplifyResult(m);
temp = m;

if size(m,1) > 1
    % For each entry apply Turn; this denotes that it is a multivector
    for i = 1:size(m,1)
        temp(i,:) = Turn(m(i,:));
    end
else
    % If a k-blade split entries, reverse order and apply the geometric
    % product. Otherwise, don't do nothing.
    test = sum(abs(m)>0);
    if test > 1
        mat = zeros(test,size(m,2));
        idx = find(m);
        coeff = m(idx(1));
        for j = 1:length(idx)
            mat(j,idx(j)) = m(:,idx(j));
        end
        mat = flipud(mat); % Reverse
        % Geometric Product
        mat = mat / coeff;
        temp = mat(1,:);
        for j = 2:length(idx)
            temp = GeometricProduct(temp,mat(j,:));
        end
        temp = coeff * temp;
    end
end
out = temp;

