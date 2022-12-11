function [R,Y,U,T] = PM_PI(X, ref)
    tfinal = 160;
    d_T = 0.2;

    time = 0:d_T:tfinal;

    U(1)=0; % Control action or manual input
    Y(1)=0; % Process response
    R(1)=0; % Reference
    T(1)=0; % Time vector

    for t = time
        if nargin == 1
            r = sp(t);
        else
            r = ref;
        end
        [~,y] = ode45(@PM, 0:d_T:d_T,[Y(end) U(end)]);
        u = CTR_PI(r, y(end,1), [X,d_T]);

        R(end+1,1)=r;
        Y(end+1,1)=y(end,1);
        U(end+1,1)=u;
        T(end+1,1)=t;
    end
end

