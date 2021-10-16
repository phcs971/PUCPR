clc
clear

syms s t

R = 10;
R1 = 5;
R2 = 10;
C = 5;
C1 = 15;
C2 = 3;
L = 2;

fprintf("a)\n")

F1 = tf(1, [L R]);
F2 = tf(1, [C 0]);

Voa = feedback(F1*F2, 1)
fprintf("    Zeros: %.3f;\n", cell2mat(zpk(Voa).Z));
fprintf("    Polos:")
fprintf(" %.3f;", cell2mat(zpk(Voa).P));
fprintf("\n\n")

fprintf("b)\n")

G1 = tf(1, R1);
G2 = tf(1, [C1 0]);
G3 = tf(1, R2);
G4 = tf(1, [C2 0]);

G5 = feedback(G1*G2, 1);
G6 = feedback(G3*G4, 1);

G7 = 1 / (G1 * G4);

Vob = feedback(G5*G6, G7)
fprintf("    Zeros: %.3f;\n", cell2mat(zpk(Vob).Z));
fprintf("    Polos:")
fprintf(" %.3f;", cell2mat(zpk(Vob).P));
fprintf("\n\n")

input("Enter para continuar...")

Vob_sym = tfToSym(Vob);
vob = ilaplace(partfrac(Vob_sym)) * 2;
prettu(vob)
time = 0:1:1000;
result = double(subs(vob, t, time));
figure(1)
plot(time, result)
xlabel("Time (seconds)")
ylabel("Vo(t) (volts)")

input("Enter para continuar...")

figure(2)
step(Voa)
hold on
step(Vob)
