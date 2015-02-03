function out = basicGroup(in)

% BASICGROUP(TUPLE) assigns group number to the corresponding basis. It
% does not actually corresponds to the same k-blade, it is random for
% speed
%
% Version: 1.0 (Nov, 2010)
% Copyright (c) 2010, Aragon-Camarasa, G., Aragon-Gonzalez, G.;
% Aragon J. L. & Rodriguez-Andrade, M. A.

idx = prod(find(in)); %Memory problems when Pseudoscalar(20)
% idx = sum(find(in));
out = sum(abs(in)) * idx;