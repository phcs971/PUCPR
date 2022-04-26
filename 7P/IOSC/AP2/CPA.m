%% Control Performance Assessment (CPA)
% Script to evaluate controller performance assesment
%% Author
% Gilberto Reynoso Meza (ORCid 0000-0002-8392-6225)
% @gilreyme
% http://www.researchgate.net/profile/Gilberto_Reynoso-Meza
% Version: Sep/2019

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

Model=1;

%% Load Model

LoadModel;
CalculaModelo;

%% Running simulation to collect data from CONTROL LOOP

sim('BaseControl');

%% Ploting time response y(t), u(t), e(t)
figure(2);

subplot(311);
plot(OutputRead(:,1),OutputRead(:,2),'b','linewidth', 2); hold on;
plot(Reference(:,1),Reference(:,2),'k','linewidth', 2); hold on;
ylabel('Output [-]');
grid on;

subplot(312);
plot(Input(:,1),Input(:,2),'color',[0, 0.5, 0],'linewidth', 2);
xlabel('Time [s]');
ylabel('Input [-]');
grid on;

subplot(313);
plot(Error(:,1),Error(:,2),'r','linewidth', 2);
xlabel('Time [s]');
ylabel('Error [-]');
grid on;

%% Control performance assesment : dynamic response

Tt=Reference(:,1);
Rt=Reference(:,2);
Yt=OutputRead(:,2);
Ut=Input(:,2);

IAE = sum(abs(Rt-Yt))

TV = sum(abs(diff(Ut)))

