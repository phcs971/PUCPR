

function [Mp, ts] = calcula_criterios(numerador,denominador)
    f = feedback(tf(numerador, denominador), 1);
    t = 0: 0.001: 10;
    u = step(f, t);
    settling_value = u(end);
    
    Mp = (max(u) - settling_value) * 100 / max(u);

    settled = find(abs(u - u(end)) < 0.02 * settling_value);
    
    settled_time = settled(end);
    for i = find(settled == settled(end)) - 1:-1: 1
        current = settled(i);
        if current + 1 == settled_time
            settled_time = current;
        end
    end
    ts = t(settled_time);
end


