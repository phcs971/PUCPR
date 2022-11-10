%% CF - PI Controller - One objective

function I = First_CF(Kp, Ti)
    try
        [y,t] = First_PM(Kp, Ti);
        info = stepinfo(y, t, 1);
    
        Model = tf(2.3, [4 1], 'inputDelay', 0.5);
        Controller = Kp * tf([Ti 1], [Ti 0]);
    
        margin = allmargin(Controller * Model);
    
        if margin.Stable == 1 && info.SettlingTime <= 15
            I = info.SettlingTime;
        elseif margin.Stable == 0
            I = 100;
        else
            I = 50;
        end
    catch
        I = 1000;
    end
end

