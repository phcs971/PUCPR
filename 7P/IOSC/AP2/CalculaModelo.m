fprintf("\nModelo %d:\n\n", Model)
[k, tau, T] = calcula_criterios(num, den, delay);
pade(tf(k, [tau 1], 'inputDelay', T))

Kp_P = tau / (k * T);
fprintf("\nControlador P\n")
fprintf("Kp = %.3f\n", Kp_P)

Kp_PI = 0.9 * Kp_P;
Ti_PI = T / 0.3;
fprintf("\nControlador PI\n")
fprintf("Kp = %.3f\n", Kp_PI)
fprintf("Ti = %.3f\n", Ti_PI)

Kp_PID = 1.2 * Kp_P;
Ti_PID = 2 * T;
Td_PID = 0.5 * T;
fprintf("\nControlador PID\n")
fprintf("Kp = %.3f\n", Kp_PID)
fprintf("Ti = %.3f\n", Ti_PID)
fprintf("Td = %.3f\n", Td_PID)