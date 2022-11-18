%% Set-point profiler
% Use this scrip to pass a set-point (sp) profile. 
%% Author
% Gilberto Reynoso Meza (ORCid 0000-0002-8392-6225)
% @gilreyme
% http://www.researchgate.net/profile/Gilberto_Reynoso-Meza
% Version: Jun/2020

function r=sp(t)

    if t<20
        r=0;
    elseif t>=20 && t<40
        r=0.2;
    elseif t>=40 && t<60
        r=0.3;
    elseif t>=60 && t<80
        r=0.5;
    elseif t>=80 && t<100
        r=0.75;
    elseif t>=100 && t<120
        r=0.65;
    elseif t>=120 && t<140
        r=0.45;
    elseif t>=140 && t<160
        r=0.25;
    elseif t>=160 && t<200
        r=0.75;
    elseif t>=200 && t<240
        r=0.25;
    else
        r=0.5;
    end