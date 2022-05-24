fprintf("\nModelo %d:\n\n", Model)
if Model == 6
    Ku = 3.19;
    Pu = 1/1.96;
    
    Kp_P = 0.5 * Ku;

    Kp_PI = 0.45 * Ku;
    Ti_PI = Pu / 1.2;
    
    Kv = 1;
    L = 1;
    
    CKp_P = 1;
    
    CKp_PI = 0.35 / (Kv * L);
    CTi_PI = 13.4 * L;
else
    [k, tau, T] = calcula_criterios(num, den, delay);
    pade(tf(k, [tau 1], 'inputDelay', T))

    Kp_P = tau / (k * T);

    Kp_PI = 0.9 * Kp_P;
    Ti_PI = T / 0.3;
    
    CKp_P = 0.3 * tau / (k * T);
    
    CKp_PI = 0.35 * tau / (k * T);
    CTi_PI = 1.16 * tau;
    
    
end

fprintf("\nControlador P\n")
    fprintf("Kp = %.3f\n", Kp_P)

    fprintf("\nControlador PI\n")
    fprintf("Kp = %.3f\n", Kp_PI)
    fprintf("Ti = %.3f\n", Ti_PI)

    fprintf("\nControlador CHR P\n")
    fprintf("Kp = %.3f\n", CKp_P)

    fprintf("\nControlador CHR PI\n")
    fprintf("Kp = %.3f\n", CKp_PI)
    fprintf("Ti = %.3f\n", CTi_PI)