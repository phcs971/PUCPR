function rr(theta1, theta2, l)
    if ~exist('l', 'var')
        l = 0.5;
    end
    t01 = [
        cosd(theta1) -sind(theta1) 0 0;
        sind(theta1) cosd(theta1)  0 0;
        0       0        1 0;
        0       0        0 1;
    ] * [
        1 0 0 l;
        0 1 0 0;
        0 0 1 0;
        0 0 0 1;
    ];
    
    t12 = [
        cosd(theta2) -sind(theta2) 0 0;
        sind(theta2) cosd(theta2)  0 0;
        0       0        1 0;
        0       0        0 1;
    ] * [
        1 0 0 l;
        0 1 0 0;
        0 0 1 0;
        0 0 0 1;
    ];

    t02 = t01 * t12;

    p0 = [0; 0; 0; 1];
    
    p1 = t01 * p0;
    
    p2 = t02 * p0;
    
    x = [p0(1) p1(1) p2(1)];
    y = [p0(3) p1(3) p2(3)];
    z = [p0(2) p1(2) p2(2)];
    
    plot3(x, y, z, '-o', 'Color', 'r', 'MarkerFaceColor', 'b')
    xlabel("X")
    ylabel("Z")
    zlabel("Y")
    set(gca, 'ydir', 'reverse')
    grid on
    daspect([1 1 1])
   
end

