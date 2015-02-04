function [A, B, sizA, sizB] = setDimensions(A, B, sizA, sizB)

% Checks if both vectors have equal or diferent dimension (columns). If
% not, set the correct dimension accordingly

if sizA(2) ~= sizB(2)
    if sizA(2) < sizB(2)
        A = [A, zeros(sizA(1), sizB(2) - sizA(2))];
        sizA(2) = sizB(2);
    else
        B = [B, zeros(sizB(1), sizA(2) - sizB(2))];
        sizB(2) = sizA(2);
    end
end