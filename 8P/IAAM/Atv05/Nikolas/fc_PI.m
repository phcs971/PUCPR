% Função de Custo - Controlador PI - Um objetivo

% Se for utilizar Simulink -> try / catch

function I = fc_PI(Kp,Ti)
    try
        [y,t] = mp_PI(Kp,Ti);
    
        Step = stepinfo(y,t,1);
    
        Model = tf(2.3,[4 1],'inputdelay',0.5);
        Controller = Kp * tf([Ti 1],[Ti 0]);
    
        Parametros = allmargin(Controller*Model);
        
        if Parametros.Stable == 1 && Step.SettlingTime < 15
            I = Step.SettlingTime;
        elseif Parametros.Stable == 0
            I = 100;
        else
            I = 50;
        end
    catch
        I = 1000;
    end
end