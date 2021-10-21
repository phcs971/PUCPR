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

H1_sys = tfToSym(H1);
h1 = ilaplace(partfrac(H1_sys / s));
fprintf("\n    h1 =\n\n")
pretty(h1)

time = 0:0.1:300;
result = double(subs(h1, t, time));
stable = time.^0 + 3;
figure(1)
hold on
p1 = plot(time, result, 'b');
p2 = plot(time, stable, 'r', 'LineStyle', '--', 'LineWidth', 2);
xlabel("Tempo (s)")
ylabel("Nível do Reservatório (m)")
legend([p1, p2], ["Resposta", "Valor de Regime"]);
hold off

input("Enter para continuar...")

figure(2)
hold on
step(H1)
step(H2)
step(Q1)

title("")
xlabel("Tempo")
ylabel("Amplitude")

figure(3)
hold on
impulse(H1)
impulse(H2)
impulse(Q1)

title("")
xlabel("Tempo")
ylabel("Amplitude")

figure(4)
hold on
time = 0:0.01:40;
u = 3 * sin(pi * time);
lsim(H1, u, time)
lsim(H2, u, time)
lsim(Q1, u, time)

title("")
xlabel("Tempo")
ylabel("Amplitude")