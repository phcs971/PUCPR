function abbirb140(t1, t2, t3, t4, t5, t6)
    dh = [
        [  70, 352, -90,       t1 ];
        [ 360,   0,   0,  t2 - 90 ];
        [   0,   0, -90,       t3 ];
        [   0, 380,  90,       t4 ];
        [   0,   0,  90, t5 + 180 ];
        [   0,  65,   0,       t6 ];
    ];
    A = eye(4);
    p0 = [ 0 0 0 1];
    x = [0];
    y = [0];
    z = [0];
    for i = 1:6
        a = dh(i);
        d = dh(i + 6);
        alfa = dh(i + 12);
        t = dh(i + 18);
        k1 = [
          cosd(t) -sind(t) 0 0
          sind(t)  cosd(t) 0 0
                0        0 1 0
                0        0 0 1
        ];
        k2 = [
          1 0 0 0
          0 1 0 0
          0 0 1 d
          0 0 0 1
        ];
        k3 = [
          1 0 0 a
          0 1 0 0
          0 0 1 0
          0 0 0 1
        ];
        k4 = [
          1          0           0 0
          0 cosd(alfa) -sind(alfa) 0
          0 sind(alfa)  cosd(alfa) 0
          0          0           0 1 
        ];
    
        k = k1 * k2 * k3 * k4;
    
        A = A * k;
        
        p = A * p0';
        x(i + 1) = p(1);
        y(i + 1) = p(2);
        z(i + 1) = p(3);
    end
    
    plot3(x, y, z, '-o', 'Color', 'r', 'MarkerFaceColor', 'b')
    xlabel("X (mm)")
    ylabel("Y (mm)")
    zlabel("Z (mm)")
    grid on
    daspect([1 1 1])
end

