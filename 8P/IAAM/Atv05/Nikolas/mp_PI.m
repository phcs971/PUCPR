% Modelo Paramétrico -> Malha Fechada de Controle - Controlador PI - Step
% Test

function [y,t] = mp_PI(Kp,Ti)

    Model = tf(2.3,[4 1],'inputdelay',0.5);
    Controller = Kp * tf([Ti 1],[Ti 0]);
    CL = feedback(Controller*Model,1);

    [y,t] = step(CL,0:0.05:20);

end