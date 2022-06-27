close all
clear

w = waitbar(0, "Carregando Modelos");

subplot(211);
x = [0 50 50 0];
y = [40 40 60 60];
patch(x,y,'g','LineStyle','none'); hold on;
alpha(.1)

% patient = 36;
set1 = 52;
k1 = -21.6730;
ti1 = 4.6667;

% patient = 18;
set2 = 47;
k2 = -13.56;
ti2 = 5.75;

% stable1 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 21 22 24 25 27 28 29 30 31 32 33 34 35 36 37 38 40 41 42 43 43 46 47];
% stable2 = [15 16 17 18 19 20 23 26 45];

for i = 1:47
    try 
        if i == 39
            continue
        else
            waitbar(i/48, w, "Carregando Modelo " + i);
            
            patient = i;

            LoadPatient;

            if age >= 15 || imc <= 14.5 || imc >= 27.5 || (age <= 8 && imc >= 17) || (gender == 0 && height > 160 && height <=165)
                Ti = ti2;
                setpoint = set2;
                Kp = k2;
            else
                Ti = ti1;
                setpoint = set1;
                Kp = k1;
            end
            
            result = sim("Propofol_Children");
        
            out = result.Out(:,2);
            time = result.Out(:,1);
            control = result.Control(:,2);
        
            subplot(211);
            plot(time, out); hold on;
            ylim([20 100])
            ylabel("Resposta")
            grid on;
            
            subplot(212);
            plot(time, control); hold on;
            ylabel("Controle")

            grid on;
        end
    catch E
        fprintf("Erro: %d\n", i)
    end
end

close(w);
