peak = 500;
result = sim("ChildrenModel.slx");

time = result.Out(:,1);
y = result.Out(:,2);
info = stepinfo(y, time, y(end), y(1));

K = (min(y) - max(y)) / peak;
T = delay/60;
tau = info.SettlingTime / 4;

model = tf(K, [tau 1], 'inputDelay', T);
% step(model, 100)

Kp = 0.5 * tau / (K * T);
Ti = 4 * T;
