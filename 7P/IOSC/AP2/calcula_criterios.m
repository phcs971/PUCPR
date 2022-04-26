function [k, tau, T] = calcula_criterios(numerador,denominador, delay)
    f = pade(tf(numerador, denominador, 'inputDelay', delay));
    [u, t] = step(f);
    k = u(end);
    
    settled_2 = find(abs(u - u(end)) < 0.02 * k);
    ts_2 = t(settled_2(1));
    tau = ts_2 / 4;
    
    after_delay = find(u > 0.02 * k);
    T = t(after_delay(1));
    
    fprintf("k   = %.3f \n", k)
    fprintf("tau  = %.3f s\n", tau)
    fprintf("T    = %.3f s\n", T)
end

