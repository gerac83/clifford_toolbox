function out = simplifyResult(in)

% SIMPLIFYRESULT simplifies the input (vectorised code)
%
% Version: 1.0 (Nov, 2010)
% Copyright (c) 2010, Aragon-Camarasa, G., Aragon-Gonzalez, G.;
% Aragon J. L. & Rodriguez-Andrade, M. A.

% Machine precision
global epsilon

if isempty(epsilon)
    Set_Epsilon;
end

threshold = epsilon;

sumIn = sum(sum(abs(in),2),1);
if sumIn > 0
    group = zeros(size(in,1),1);
    for i = 1:size(in,1)
        tuple = abs(in(i,:)) > 0;
        group(i) = basicGroup(tuple);
    end
    
    idx = group > 0;
    group = group(idx);
    in = in(idx,:);
    
    temp = accumarray(group, (1:length(group))', [max(group) 1], @(idx) {sum(in(idx,1:end),1)});
    out = cat(1,temp{:});
    idx = logical(sum(abs(out) < threshold & out ~= 0,2));
    out(idx,:) = []; % Remove vectors that are below machine precision
else
    out = in;
end

% Remove empty vectors
idx = sum(abs(out),2) == 0;
out(idx,:) = [];

if isempty(out) || sum(abs(out(:))) == 0
    out = 0;
end
