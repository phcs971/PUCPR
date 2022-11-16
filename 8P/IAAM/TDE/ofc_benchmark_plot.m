%close all;

% Set font size for axis labels and legends
font_size = 16;

Nz      = get(simOut,'Nz');
Nz_cmd  = get(simOut,'Nz_cmd');
current = get(simOut,'current');
flight  = get(simOut,'flight');
fpa     = get(simOut,'fpa');
fpa_ref = get(simOut,'fpa_ref');
servo      = get(simOut,'servo');
time    = get(simOut,'time');

delta_des  = servo(:,1);
delta_meas = servo(:,2);
delta      = servo(:,3);

if ~isempty(find(ismember(simOut.who, 'delta_est')))
    delta_est  = get(simOut,'delta_est');
else
    delta_est  = NaN*ones(size(time));
end
if ~isempty(find(ismember(simOut.who, 'residual')))
    residual  = get(simOut,'residual');
else
    residual = NaN*ones(size(time));
end

Vbar    = flight(:,1);
alpha   = flight(:,2);
q       = flight(:,3);
theta   = flight(:,4);

% Plot control surface deflection (command and true)
figure;
plot(time,delta_des);
hold on;
plot(time,delta);
hold off;
grid on;
xlabel('time [s]','FontSize',font_size);
ylabel('control surface deflection [deg]','FontSize',font_size);
h = legend('commanded deflection','actual deflection');
set(h,'FontSize',font_size)
title('Control surface deflection: commanded vs actual','FontSize',font_size);

% Plot control surface deflection (measured and modelled)
% Plot residual
figure;
subplot(211);
plot(time,delta_meas);
hold on;
plot(time,delta_est);
hold off;
grid on;
ylabel('control surface deflection [deg]','FontSize',font_size);
h = legend('measured deflection','modelled deflection');
set(h,'FontSize',font_size);
title('Control surface deflection: measured vs modelled, and residual signal','FontSize',font_size);

subplot(212);
plot(time,residual);
grid on;
xlabel('time [s]','FontSize',font_size);
ylabel('residual [deg]','FontSize',font_size);

% Plot load factor (commanded and actual)
figure;
plot(time,Nz_cmd);
hold on;
plot(time,Nz);
hold off;
grid on;
xlabel('time [s]','FontSize',font_size);
ylabel('load factor [g]','FontSize',font_size);
h = legend('load factor command','actual load factor');
set(h,'FontSize',font_size);
title('Normal load factor: commanded vs actual','FontSize',font_size);

% Plot flight path angle (commanded and actual)
figure;
plot(time,fpa_ref);
hold on;
plot(time,fpa);
hold off;
grid on;
xlabel('time [s]','FontSize',font_size);
ylabel('flight path angle [deg]','FontSize',font_size);
h = legend('flight path angle command','flight path angle');
set(h,'FontSize',font_size);
title('Flight path angle: commanded vs actual','FontSize',font_size);

% Plot longitudinal states (airspeed, angle of attack, pitch rate, pitch)
figure;
subplot(411);
plot(time,Vbar);
grid on;
ylabel('airspeed [m/s]');
title('Aircraft longitudinal states','FontSize',font_size);
subplot(412);
plot(time,alpha);
grid on;
ylabel('angle of attack [deg]');
subplot(413);
plot(time,q);
grid on;
ylabel('pitch rate [deg/s]');
subplot(414);
plot(time,theta);
grid on;
ylabel('pitch angle [deg]');
xlabel('time [s]');
