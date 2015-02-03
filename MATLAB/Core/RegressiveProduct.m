function out = RegressiveProduct(v, w, x)

%REGRESSIVEPRODUCT(V,W) calculate the rejection of the vector v on the
% subspace defined by the r-blade w.
%
% Based on: Clifford Algebra with Mathematica (2008) http://arxiv.org/abs/0810.2412
% Version: 0.7 (Oct, 2011)
% Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.,
% Aragon J. L. & Rodriguez-Andrade, M. A.

global signature

if isempty(signature)
    Set_Signature; % Set default
end

flag = 0;
if ischar(v)
    v = GAstring2mat(v);
    flag = 1;
end
if ischar(w)
    w = GAstring2mat(w);
    flag = 1;
end

if nargin > 2
    if isnumeric(x)
        if x > 0
            Set_Signature(x, 0, 0);
            vx = Dualize(v,x);
            wx = Dualize(w,x);
            outProd = OuterProduct(vx,wx);
            out = Dualize(outProd, x);
        end
    else
        error('Third argument must be numeric and possitive');
    end
else
    out = RegressiveProduct(v, w, sum(signature(:)));
end

if flag
    out = GAmat2string(out);
end



