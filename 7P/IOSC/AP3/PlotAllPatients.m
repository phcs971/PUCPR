close all
clear

w = waitbar(0, "Carregando Modelos");

subplot(211);
x = [0 50 50 0];
y = [40 40 60 60];
patch(x,y,'g','LineStyle','none'); hold on;
alpha(.1)


patient = 36;
LoadPatient;
CalculaModelo;

for i = 1:47
    try 
        if i == 39
            continue
        else
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
%     pause(1)
end

close(w);
