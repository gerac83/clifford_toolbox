function out = phi(s,B)

if size(B,1) < 2
    error('TBD!');
end

if s == 0
    out = eye(size(B,1));
    return;
end

one = -1 / getScalar(GAproduct(s,s));

res = zeros(size(B,1),size(B,1));
for l = 1:size(B,1)
    for j = 1:size(B,1)
        if l == j
            two = getScalar(GAinner(s,B(j,:))) ^ 2 / getScalar(GAproduct(B(j,:), B(j,:)));
            three = 0;
            for i = 1:size(B,1)
                if i == j
                    temp = 0;
                else
                    num = getScalar(GAinner(s,B(i,:))) ^ 2;
                    den = getScalar(GAproduct(B(i,:), B(i,:)));
                    temp = num / den;
                end
                three = three + temp;
            end
            res(l,j) = two - three;
        else
            two = getScalar(GAinner(s,B(j,:)));
            three = getScalar(GAinner(s,B(l,:))) / getScalar(GAproduct(B(l,:), B(l,:)));
            res(l,j) = 2 * two * three;
        end
    end
end

out = one .* res;

% Auxiliar function
function out = getScalar(in)

temp = sum(abs(in),2);
idx = temp(:,1) == 0;
if numel(in) ~= 1
    if sum(~idx) > 1
        error('Not a scalar!');
    else
        if sum(in(~idx,2:end)) > 0
            error('Not a scalar!');
        end
    end
else
    idx = 0;
end
in = in(~idx,:);
out = in(1);



