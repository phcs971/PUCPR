clc

w = waitbar(0, "Carregando Modelos");

subplot(211);
x = [0 100 100 0];
y = [40 40 60 60];
patch(x,y,'g','LineStyle','none'); hold on;
alpha(.1)

for i = 1:47
    if i == 39
        continue
    else
        waitbar(i/48, w, "Carregando Modelo " + i);
        
        patient = i;
        LoadPatient
        
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
end

close(w);
