figure(1)
t = [0 : 0.1 : 10];
for i = 1:9
    Model = i;
    LoadModel;
    m = tf(num, den, 'inputDelay', delay);
    u = step(m, t);
    plot(t, u,'linewidth', 2); hold on;
end
legend("M(1)", "M(2)", "M(3)", "M(4)", "M(5)", "M(6)", "M(7)", "M(8)", "M(9)")
ylim([0 6]);
grid on;