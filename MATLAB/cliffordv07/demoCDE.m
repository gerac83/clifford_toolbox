% Test matrices
A1 = [6/7, 2/7, 3/7;
    2/7, 3/7, -6/7;
    -3/7, 6/7, 2/7];

A2 = [2/sqrt(5), 1/sqrt(30), 1/sqrt(6);
    -1/sqrt(5), 2/sqrt(30), 2/sqrt(6);
    0, -5/sqrt(30), 1/sqrt(6)];

A3 = 1/2*[1, -1, -1, -1;
    1, -1, 1, 1;
    1, 1, -1, 1;
    1, 1, 1, -1];

A4 = [1, 0, 0;
    0, 2, 1;
    0, 1, 1];

A5 = [1, 0, 0;
    0, sqrt(3)/2, 1/2;
    0, -1/2, sqrt(3)/2];

A6 = [-1, 0, 0, 0;
    0, -1, 0, 0;
    0, 0, -1, 0;
    0, 0, 0, -1];

A7 = [0, -1, 0, 0, 0;
    1, 0, 0, 0, 0;
    0, 0, -1, 0, 0;
    0, 0, 0, -1, 0;
    0, 0, 0, 0, 1];

disp('A1');
AlgoCDE(A1);
disp(' ');
disp('A2');
AlgoCDE(A2);
disp(' ');
disp('A3');
AlgoCDE(A3);
disp(' ');
disp('A4');
AlgoCDE(A4);
disp(' ');
disp('A5');
AlgoCDE(A5);
disp(' ');
disp('A6');
AlgoCDE(A6);
disp(' ');
disp('A7');
AlgoCDE(A7);
disp(' ');









