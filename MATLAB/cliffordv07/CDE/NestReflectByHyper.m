function out = NestReflectByHyper(v, a, h)

if h - 1 > 1
    if ~isempty(Coefficient(v{h-1}))
        % ReflectByHyper[v[[h - 1]], NestReflectByHyper[v, a, h - 1]]
        out = ReflectByHyper(v{h - 1}, NestReflectByHyper(v, a, h - 1));
        return;
    else
        % ReflectByHyper[v[[h - 2]], NestReflectByHyper[v, a, h - 2]]
        out = ReflectByHyper(v{h - 2}, NestReflectByHyper(v, a, h - 2));
        return;
    end
end

if h - 1 == 0
    out = a;
    return;
else
    if sum(Coefficient(v{1})) == 0 && length(Coefficient(v{1})) < 1
        out = a;
        return;
    else
        %ReflectByHyper[v[[h - 1]], a]
        out = ReflectByHyper(v{h - 1}, a);
        return;
    end
end

% Auxliar function (Mathematica wrappers)
function out = Coefficient(in)

out = in(abs(in)>0);

