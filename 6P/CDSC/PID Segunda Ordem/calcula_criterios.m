function [Mp, tp, ts_2, ts_5, tr, td] = calcula_criterios(numerador,denominador)
    f = tf(numerador, denominador);
    pretty(f);
    [u, t] = step(f);
    settling_value = u(end);
    
    Mp = (max(u) - settling_value) * 100 / max(u);
    
    index_tp = find(u == max(u));
    tp = t(index_tp(1));
    
    settled_2 = find(abs(u - u(end)) < 0.02 * settling_value);
    ts_2 = t(settled_2(1));
    
    settled_5 = find(abs(u - u(end)) < 0.05 * settling_value);
    ts_5 = t(settled_5(1));
    
    after_tr = find(u >= settling_value);
    tr = t(after_tr(1));
    
    after_td = find(u >= settling_value / 2);
    td = t(after_td(1));
    
    fprintf("Mp   = %.3f %%\n", Mp)
    fprintf("tp   = %.3f s\n", tp)
    fprintf("ts_2 = %.3f s\n", ts_2)
    fprintf("ts_5 = %.3f s\n", ts_5)
    fprintf("tr   = %.3f s\n", tr)
    fprintf("td   = %.3f s\n", td)
end

