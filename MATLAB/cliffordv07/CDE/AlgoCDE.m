function [c, B] = AlgoCDE(A, treshold, verbose)

if nargin < 2 || isempty(treshold)
    treshold = eps;
end
if nargin < 3
    verbose = 1;
end

if verbose
    disp('**************************************************');
    disp('A:');
    disp(num2str(A));
end

AT = A';

CanonicalB = [zeros(length(AT),1), eye(length(AT))];

a = cell(1,length(AT));
for i = 1:length(AT)
    a{i} = ToBasis(AT(i,:));
end

if verbose, tic; end

c = cell(1,length(AT));
c{1} = zeros(1,length(AT));
B = cell(1,length(AT));
for i = 1:length(AT)
    c{i} = NestReflectByHyper(c, a{i}, i);
    c{i} = GAarithmetic('minus', c{i}, ['e' num2str(i)]);%CanonicalB(i,:)
    B{i} = phi(c{i}, CanonicalB);
end

if verbose, toc; end

if verbose
    disp('DISPLAYING RESULTS')
    disp('Reflections by hyperplane:')
    for i = 1:length(c)
        disp(['c[' num2str(i) ']: ' GAmat2string(c{i})]);
    end
    disp(' ');
    for i = 1:length(B)
        disp(['B[' num2str(i) ']: ']);
        disp(num2str(B{i}));
    end
    disp(' ');
    M1 = prodRecursive(fliplr(B)) * A;
    M1 = set2MachinePrecision(M1, treshold);
    M2 = prodRecursive(B) - A;
    M2 = set2MachinePrecision(M2, treshold);
    disp('Validation...')
    disp('B[1]*B[2]* ... * B[n] * A');
    disp(M1);
    disp('B[1]*B[2]* ... * B[n] - A');
    disp(M2);
    disp('**************************************************');
end

function out = prodRecursive(in)

A = in{1};
B = in{2};
out = A*B;

for i = 3:length(in) % Iterate until no input arguments remain
    A = out;
    B = in{i};
    out = A*B;
end

function out = set2MachinePrecision(in, treshold)

idx = abs(in) < treshold;

in(idx) = 0;
out = in;



