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

Vob_sym = tfToSym(Vob) * 2/s;
vob = ilaplace(partfrac(Vob_sym));
pretty(vob)
time = 0:1:1000;
result = double(subs(vob, t, time));
settled = find(abs(result - result(end)) < 0.02*max(result));
settlingTime = settled(1);
figure(1)
hold on
p1 = plot(time, result);

p2 = xline(settlingTime, 'r', 'LineStyle', '--', 'LineWidth', 2);
xlabel("Tempo (s)")
ylabel("Potência de Saída (V)")

legend([p1, p2], ["Resposta", "Tempo de Estabilidade"]);
hold off
input("Enter para continuar...")

figure(2)
hold on
step(Voa, 'b');
step(Vob, 'r');
s1Info = stepinfo(Voa);
s2Info = stepinfo(Vob);

l1 = xline(s1Info.SettlingTime, 'b', 'LineStyle', '--', 'LineWidth', 2);
l2 = xline(s2Info.SettlingTime, 'r', 'LineStyle', '--', 'LineWidth', 2);

legend([l1, l2], ["Tempo de Estabilidade A", "Tempo de Estabilidade B"]);

title("")
xlabel("Tempo")
ylabel("Potência de Saída (V)")

