close all
clear

w = waitbar(0, "Carregando Modelos");

subplot(211);
x = [0 50 50 0];
y = [40 40 60 60];
patch(x,y,'g','LineStyle','none'); hold on;
alpha(.1)


patient = 36;
setpoint = 52;
% patient = 18;
% setpoint = 47;
LoadPatient;
CalculaModelo;

% for i = 1:47
up = [4 10 12 27 35 43];
ok = [1 2 3 5 6 7 8 9 11 13 14 18 21 22 24 25 28 29 30 31 32 33 34 36 37 38 40 41 42 44 45 46 47];
down = [15 16 17 19 20 23 26 27];

ok2 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 21 22 24 25 27 28 29 30 31 32 33 34 35 36 37 38 40 41 42 43 43 46 47];
down2 = [15 16 17 18 19 20 23 26 45];

for i = ok2
    try 
        if i == 39
            continue
        else
            fprintf("Modelo %d\n", i)
            waitbar(i/48, w, "Carregando Modelo " + i);
            
            patient = i;
            LoadPatient;
%             CalculaModelo;
            
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
            if min(out) < 40
                fprintf("Baixo: %d\n", i)
            end
        end
    catch E
        fprintf("Erro: %d\n", i)
    end
%     input("Enter para continuar\n")
%     pause(1)
end

close(w);
