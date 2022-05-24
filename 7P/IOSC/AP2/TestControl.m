%% Plot features

close all;
clear all;
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 16)
% Change default text fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0, 'DefaultAxesFontWeight','Bold')
set(0,'DefaultTextFontSize', 16)

%% Define process to control: [1, 2, 3, 4, 5, 6, 7, 8, 9];

Model=6;

%% Load Model

LoadModel;
CalculaModelo;

%% Simulation
times = [30 40 15 70 40 40 30 50 60];
time = times(Model);

simulation = sim("PIDControl");
result = simulation.result;
t = result(:,1);
in = result(:,2);
out = result(:,3);
p = result(:,4);
pi = result(:,5);
control = result(:,6);
error = result(:,7);
p2 = result(:,8);
pi2 = result(:,9);
control2 = result(:,10);
error2 = result(:,11);

%% Plot

figure(2)
subplot(311);
plot(t, in,'k','linewidth', 1); hold on;
plot(t, out,'m','linewidth', 2); hold on;
plot(t, pi,'g','linewidth', 2); hold on;
plot(t, pi2,'b','linewidth', 2); hold on;

if Model == 6
%     plot(t, p,'g','linewidth', 2); hold on;
%     plot(t, p2, 'b','linewidth', 2); hold on;
    legend("Entrada", "Saída", "Controlador PI (ZN)", "Controlador PI (Åstrom)")
    ylim([-0.5 2])
else
    legend("Entrada", "Saída", "Controlador PI (ZN)", "Controlador PI (CHR)")
end

grid on;

subplot(312);
plot(t, in, 'k', 'lineWidth', 1); hold on;
plot(t, control, 'g', 'lineWidth', 2); hold on;
plot(t, control2, 'b', 'lineWidth', 2); hold on;
if Model == 6
    legend("Entrada", "Controle (ZN)", "Controle (Åstrom)");
else
    legend("Entrada", "Controle (ZN)", "Controle (CHR)");
end
grid on;

subplot(313);
plot(t, in, 'k', 'lineWidth', 1); hold on;
plot(t, error, 'g', 'lineWidth', 2); hold on;
plot(t, error2, 'b', 'lineWidth', 2); hold on;
if Model == 6
    legend("Entrada", "Erro (ZN)", "Erro (Åstrom)");
else
    legend("Entrada", "Erro (ZN)", "Erro (CHR)");
end
grid on;

%% Control performance assesment : dynamic response

Tt=t;
Rt=in;
if Model == 6
    Yt = p;
    Yt2 = p2;
else
    Yt=pi;
    Yt2=pi2;
end
Ut=control;
Ut2=control2;

IAE = sum(abs(Rt-Yt))
TV = sum(abs(diff(Ut)))

IAE2 = sum(abs(Rt-Yt2))
TV2 = sum(abs(diff(Ut2)))