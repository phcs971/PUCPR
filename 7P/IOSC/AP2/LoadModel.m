%% Test batch process control
% This script loads a model from the test batch stated by Karl J. Astrom.
%% Author
% Gilberto Reynoso Meza (ORCid 0000-0002-8392-6225)
% @gilreyme
% http://www.researchgate.net/profile/Gilberto_Reynoso-Meza
% Version: Sep/2019

switch Model
    
    case 1
        num=1;
        den=[1.3 1];
        delay=1;
    case 2
        num=1;
        den=conv([0.7 1],[0.7 1]);
        delay=1;
    case 3
        num=1;
        den=conv(conv([0.05 1],[0.05 1]),[1 1]);
        delay=0;
    case 4
        num=1;
        den=conv(conv([1 1],[1 1]),conv([1 1],[1 1]));
        delay=0;
    case 5
        num=1;
        den=conv(conv([1 1],[0.4 1]),conv([0.4^2 1],[0.4^3 1]));
        delay=1;
    case 6
        num=1;
        den=[0.7 1 0];
        delay=0.3;
    case 7
        num=5;
        den=conv([5 1],[0.3 1]);
        delay=0.7;
    case 8
        num=[-1.1 1];
        den=[1 3 3 1];
        delay=0;
    case 9
        num=1;
        den=conv([1 1],[0.5^2 1.4*0.5 1]);
        delay=0;
end