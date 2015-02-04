% Copyright (c) 2010, Aragon-Camarasa, G., Aragon-Gonzalez, G.;
% Aragon J. L. & Rodriguez-Andrade, M. A.

clear;
clc;

disp('Demonstrating Geometric Algebra (A port of Clifford Algebra for Mathematica)');
disp(' ')
disp('Copyright (c) 2010, Aragon-Camarasa, G., Aragon-Gonzalez, G.;')
disp('Aragon J. L. & Rodriguez-Andrade, M. A.')
disp(' ')
disp('Press a key to continue...');
pause;

disp(' ')
disp(' ')
disp('A simple example :)')
disp('Declaring two simple variables;')
A = 'e1';
B = 'e2';

disp(' ')
disp(['A = ' A]);
disp(['B = ' B]);

disp(' ')
disp('Press a key to continue...');
pause;

disp(' ')
disp(' ')
disp('Inner, outer and geometric products;');
inner = InnerProduct(A,B);
disp(['Inner product = ' GAmat2string(inner)]);

outer = OuterProduct(A,B);
disp(['Outer product = ' GAmat2string(outer)]);

geo = GeometricProduct(A,B);
disp(['Geometric product = ' GAmat2string(geo)]);

A1 = MultivectorInverse(A);
disp(' ')
disp('Multivector inverse;');
disp(['Inverse of A = ' GAmat2string(A1)]);
B1 = MultivectorInverse(B);
disp(['Inverse of B = ' GAmat2string(B1)]);

disp(' ')
disp('Press a key to continue...');
pause;

clc;
disp('A neat example...')
disp('Reflection of a vector in a plane.')

a = 'e1 + e2';
P = 'e1e3';
I3 = 'e1e2e3';

disp(['vector = ' a]);
disp(['Plane = ' P]);
disp(' ')
disp('Press a key to continue...');
pause;

disp(' ')
r = GeometricProduct(P,I3);
disp(['Normal vector = ' GAmat2string(r)]);

reflection = GeometricProduct(r,a,-r);
disp(['Reflection = ' GAmat2string(reflection)]);

disp(' ')
disp('That`s all...');
