clc
clear all

Kp = 0.5;
Ki = 1;

P = tf(Kp, 1);
I = tf(Ki, [1 0]);

PI = P + I

fprintf("Polos:")
fprintf(" %.3f ", cell2mat(zpk(PI).P));
fprintf("\n\n")

G = tf(2, [1 2 0])

fprintf("Polos:")
fprintf(" %.3f ", cell2mat(zpk(G).P));
fprintf("\n\n")

U = feedback(PI * G, 1)

fprintf("Polos:")
fprintf(" %.3f ", cell2mat(zpk(U).P));
fprintf("\n\n")

