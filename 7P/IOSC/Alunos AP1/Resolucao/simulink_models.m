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

%% Running simulation

 in = [
       0 0.0;
     100 0.0;
     100 1.0;
     500 1.0;
 ];

% in = [
%       0 0.0;
%      50 0.0;
%      50 0.2;
%     100 0.2;
%     100 0.3;
%     250 0.3;
%     250 0.4;
%     400 0.4;
%     400 0.475;
%     500 0.475;
% ];
      
Time_sim=500;
Ts = 0.01;

m = sim('models');
figure(1);

%% Plotting time response

subplot(211);
plot(m.Output(:,1),m.Output(:,2),'b','linewidth',2);
ylabel('Fluid Level [m]');
% ylim([-0.1 1.1]);
grid on;

subplot(212);
plot(m.Input(:,1),m.Input(:,2),'color',[0, 0.5, 0],'linewidth',2);
xlabel('Time [s]');
ylabel('Valve Position [-]');
ylim([-0.1 1.1]);
grid on;