function ExLaplaceETransf()
    syms t a s w
    
    % Exercício 1
    
    fprintf("\n1)\n")
    fprintf("    a) %s\n", laplace(heaviside(t)));
    fprintf("    b) %s\n", laplace(exp(-t)));
    fprintf("    c) %s\n", laplace(t*exp(-a*t)));
    fprintf("    d) %s\n", laplace(t));
    input("\nAperte enter para continuar...")
    
    % Exercício 2
    
    fprintf("\n2)\n")
    fprintf("    a) %s\n", ilaplace(s / (s^2 + w^2)));
    fprintf("    b) %s\n", ilaplace(w / (s^2 + w^2)));
    fprintf("    c) %s\n", ilaplace(1 / (s^7)));
    input("\nAperte enter para continuar...")
    
    %Exercício 3
    
    fprintf("\n3)\n")
    fprintf("    Por favor, passe um polinômio para os próximos cálculos...\n")
    fprintf("    Para isso passe somente os coeficientes do numerador e depois do denominador no formato de lista!\n")
    fprintf("    Ex.: s / (s² - 1)\n")
    fprintf("        Numerador: [1 0]\n"); 
    fprintf("        Denominador: [1 0 -1]\n\n");
    num = input("    Numerador: ");
    den = input("    Denominador: ");
    
    sys = tf(num, den);
    sys_syms = poly2sym(num,s)/poly2sym(den,s);
    sys_spk = zpk(sys);
    
    fprintf("    a)\n        z = ");
    
    fprintf("%.3f; ", cell2mat(sys_spk.Z));
    fprintf("\n        p = ");
    fprintf("%.3f; ", cell2mat(sys_spk.P));
    
    fprintf("\n    b)\n\nPolinomial:\n\n")
    pretty(sys_syms)
    fprintf("\nFatorada:\n\n");
    [r, p, k] = residue(num, den);
    fp = 0;
    for i = 1:length(r)
        v = (r(i) / (s -p(i)) ^ sum(p(1:i)==p(i)));
        fp = fp + v;
    end
    fp = fp + poly2sym(k, s);
    pretty(fp)
    
    fprintf("\n    c)\n\nInversa de Laplace:\n\n")
    pretty(ilaplace(fp));
    
    fprintf("\n    d) Gráfico na Figura 01\n")
    [y, time] = step(sys);
    figure(1);
    plot(time, y, 'g');
    legend('f(t)');
    xlabel("Tempo (s)");
    ylabel("Amplitude (-)");
    
    fprintf("    e)\n")
    fprintf("        f(inf) = %d\n", y(end));
    fprintf("        max(f) = %d\n", max(y));
    fprintf("        porcen = %.1f %%\n", y(end) / max(y) * 100);
    input("\nAperte enter para continuar...")
    
    % Exercício 4
    
    fprintf("\n4)\n")
    fprintf("    impulse(SYS) -> Simula, e plota em um gráfico, a resposta de um sistema para uma entrada de impulso unitário. Pode ser usado com um intervalo de tempo pré determinado, múltiplos sistemas, sistemas variantes no espaço e respostas computacionais incertas. \n");
    fprintf("    lsim(SYS, u, t) -> Simula, e plota em um gráfico, a resposta de um sistema para uma entrada de arbitrária. Pode ser usado com um intervalo de tempo pré determinado, múltiplos sistemas e sistemas variantes no espaço. \n");
    input("\nAperte enter para continuar...")
    
    % Exercício 5
    
    fprintf("\n5)\n");
    time = 0:0.01:10;
    u = cos(time);
    y = lsim(tf(1, [1 1]), u, time);
    figure(2);
    plot(time, u, 'b');
    hold on;
    plot(time, y, 'g');
    legend('cos(t)', 'f(t)'); 
    xlabel("Tempo (s)");
    ylabel("Amplitude (-)");
    fprintf("    Gráfico na Figura 02\n");
end