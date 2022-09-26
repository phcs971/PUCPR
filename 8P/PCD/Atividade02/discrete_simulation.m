function [e,u,y] = discrete_simulation(dt, end_time, reference)
    t = 0:dt:end_time;
    N = size(t);

    w = reference;

    e = zeros(N); u = zeros(N); y = zeros(N);

    for k=1:N(2) - 2
        e(k+2) = w(k+1) - y(k+1);
        u(k+2) = 1.152 * u(k+1) - 0.152 * u(k) + 4.57 * e(k+2) - 7.78 * e(k+1) + 3.25 * e(k);
        y(k+2) = 1.855 * y(k+1) - 0.8607 * y(k) + 0.005352 * u(k+1) + 0.005091 * u(k);
    end
end

