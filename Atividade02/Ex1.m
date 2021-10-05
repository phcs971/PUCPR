clc
clear

C1 = 4;
C2 = 3;
R1 = 4;
R2 = 2.5;

syms s t q

H2 = tf(R2, [C2*R2, 1]);
fprintf("a) H2\n");
fprintf("    Zero: %.3f;\n", cell2mat(zpk(H2).Z));
fprintf("    Polo: %.3f;\n", cell2mat(zpk(H2).P));

H1 = tf(R1, conv([C1*R1, 1], [C2*R2, 1]));
fprintf("\n   H1\n")
fprintf("    Zero: %.3f;\n", cell2mat(zpk(H1).Z));
fprintf("    Polo: %.3f;\n", cell2mat(zpk(H1).P));

Q1 = tf(1, conv([C1*R1, 1], [C2*R2, 1]));
fprintf("\n   Q1\n")
fprintf("    Zero: %.3f;\n", cell2mat(zpk(Q1).Z));
fprintf("    Polo: %.3f;\n", cell2mat(zpk(Q1).P));



% h2 = ilaplace(( R2 / (C2*R2*s + 1) ) * q, s);
% h1 = ilaplace(( R1 / ((C1*R1*s + 1) * (C2*R2*s + 1))) * q, s);
% q1 = ilaplace( q / ((C1*R1*s + 1) * (C2*R2*s + 1)), s);
