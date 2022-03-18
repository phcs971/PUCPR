inp = ...
[
    0 1.0;
    100 1.0;
    100 2.5;
    200 2.5;
    200 1.5;
    300 1.5;
    300 4.5;
    400 4.5;
    400 10.0;
];

out = sim('teste');

figure(1);

subplot(211);
plot(out.Output(:,1), out.Output(:,2), 'b', 'linewidth', 4); 
grid on;
ylabel('output');
ylim([-10 30]);
xlim([0 500]);
grid on;

subplot(212);
plot(out.Input(:,1), out.Input(:,2), 'color', [0, 0.5, 0], 'linewidth', 4); 
grid on;
xlabel('Time [s]');
ylabel('Manual Input');
ylim([-0.1 10.1]);
xlim([0 500]);
grid on;
