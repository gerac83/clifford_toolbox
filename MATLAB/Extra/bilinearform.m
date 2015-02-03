function out = bilinearform(idx)

global signature

if isempty(signature)
    Set_Signature; % Set default
end

if ~isnumeric(idx)
    error('Argument must be a integer...');
end
   
out = NaN;
if idx <= signature(1)
    out = 1;
end
if idx > signature(1) && (idx <= signature(1) + signature(2))
    out = -1;
end
if idx > signature(1) + signature(2) + signature(3)
    out = 0;
end

if isnan(out)
    error('Error in BILINEARFORM: It was not possible to set the signature');
end

