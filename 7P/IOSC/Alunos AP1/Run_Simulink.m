%% Step test
% This script implements a test in simulink. It requires the 
% following scripts:
%
% PM_dX_----- : ODE system.
% -----_Block : Script to create a simulink block using PM_dX_-----.
% -----_OpenLoop_Simulink : Simulink file to simulate a given model.
%
%
%% Author
% Gilberto Reynoso Meza (ORCid 0000-0002-8392-6225)
% @gilreyme
% http://www.researchgate.net/profile/Gilberto_Reynoso-Meza
% Version: Aug/2019
%
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


%% Running OPEN LOOP simulation

V_Profile=[00 0.0;
          50 0.0;
          50 0.2;
          100 0.2;
          100 0.3;
          250 0.3;
          250 0.4;
          400 0.4;
          400 0.475;
          500 0.475;
          ];
     
Time_sim=500;
Ts=0.01;

sim('SphericalTank');
figure(1);

%% Plotting time response

subplot(211);
plot(H_Read(:,1),H_Read(:,2),'b','linewidth',4);
ylabel('Fluid Level [m]');
ylim([-0.1 2.1]);
grid on;

subplot(212);
plot(V(:,1),V(:,2),'color',[0, 0.5, 0],'linewidth',4);
xlabel('Time [s]');
ylabel('Valve Position [-]');
ylim([-0.1 1.1]);
grid on;