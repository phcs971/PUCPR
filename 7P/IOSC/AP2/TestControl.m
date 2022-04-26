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

Model=3;

%% Load Model

LoadModel;
CalculaModelo;

%% Simulation

time = 10;

simulation = sim("PIDControl");
result = simulation.result;
t = result(:,1);
in = result(:,2);
real_out = result(:,3);
p = result(:,4);
pi = result(:,5);
pid = result(:,6);
out = result(:,7);

%% Plot

figure(1)
plot(t, in,'k','linewidth', 1); hold on;
plot(t, real_out,'r','linewidth', 2); hold on;
% plot(t, out,'--g', 'linewidth', 2); hold on;
% legend("Output", "ZN Output")
plot(t, p,'m','linewidth', 2); hold on;
plot(t, pi,'b','linewidth', 2); hold on;
plot(t, pid,'c','linewidth', 2); hold on;
legend("Input", "Output", "Controller P", "Controller PI", "Controller PID")
grid on;
