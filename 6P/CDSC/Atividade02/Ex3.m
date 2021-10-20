clc
clear

Kp = 4;
Ti = 2;
Td = 0.8;

P = tf(Kp, 1);
I = P * tf(1, [Ti 0]);
D = P * tf([Td 0], 1);
PI = P + I;
PD = feedback(P + D, 1);
PID = feedback(P + I + D, 1);

figure(1)
step(P)
figure(2)
step(I)
figure(3)
step(PI)
figure(4)
step(PD)
figure(5)
step(PID)

time = 0:0.01:25;

figure(6)
lsim(P, time, time)
figure(7)
lsim(I, time, time)
figure(8)
lsim(PI, time, time)
figure(9)
lsim(PD, time, time)
figure(10)
lsim(PID, time, time)