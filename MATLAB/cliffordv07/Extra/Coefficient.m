function out = Coefficient(a,b)

idx = a(:,find(b)) > 0; %#ok<*FNDSB>
out = a(find(sum(idx,2)),:); 

% Find which are either scalar or vectors
test = sum(out>0,2);

for i = 1:length(test)
    if test(i) == sum(b)
        % Divided as one wants to query the coefficient of the k-blade
        out(i,1) = sum(out(i,:))/sum(b);
        out(i,find(b)) = 0;
    else
        out(i,find(b)) = 0;
    end
end