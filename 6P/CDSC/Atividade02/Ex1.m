clc
clear

C1 = 4;
C2 = 3;
R1 = 4;
R2 = 2.5;

syms s t q

H2 = tf(R2, [C2*R2, 1])
fprintf("    Zeros: %.3f;\n", cell2mat(zpk(H2).Z));
fprintf("    Polos:")
fprintf(" %.3f;", cell2mat(zpk(H2).P));
fprintf("\n\n")

H1 = tf(R1, conv([C1*R1, 1], [C2*R2, 1]))
fprintf("    Zeros: %.3f;\n", cell2mat(zpk(H1).Z));
fprintf("    Polos:")
fprintf(" %.3f;", cell2mat(zpk(H1).P));
fprintf("\n\n")

Q1 = tf(1, conv([C1*R1, 1], [C2*R2, 1]))
fprintf("    Zeros: %.3f;\n", cell2mat(zpk(Q1).Z));
fprintf("    Polos:")
fprintf(" %.3f;", cell2mat(zpk(Q1).P));
fprintf("\n\n")

input("Enter para continuar...")

H1_sys = q * R1 / ((C1*R1*s + 1) * (C2*R2*s + 1));
h1 = ilaplace(partfrac(H1_sys));
fprintf("\n    h1 =\n\n")
pretty(h1)

time = 0:0.1:100;
u = time.^0;
lsim(H1, u, time)

input("Enter para continuar...")

figure(2)
step(H1)
hold on
step(H2)
hold on
step(Q1)

figure(3)
impulse(H1)
hold on
impulse(H2)
hold on
impulse(Q1)

figure(4)
time = 0:0.01:10;
u = 3 * sin(pi * time);
lsim(H1, u, time)
hold on
lsim(H2, u, time)
hold on
lsim(Q1, u, time)