%% System simulation
% Use this script to simulate an open-loop or close-loop system. 
%% Author
% Gilberto Reynoso Meza (ORCid 0000-0002-8392-6225)
% @gilreyme
% http://www.researchgate.net/profile/Gilberto_Reynoso-Meza
% Version: Jun/2020

%% System simulation
% Use this script to simulate an open-loop (1) or close-loop (0) system. 
%% Author
% Gilberto Reynoso Meza (ORCid 0000-0002-8392-6225)
% @gilreyme
% http://www.researchgate.net/profile/Gilberto_Reynoso-Meza
% Version: Jun/2020

function [J,X]=CF_PI(X,~)

J=zeros(size(X,1),1);

for x=1:size(X,1)
    [R, Y, ~, T] = PM_PI(X(x,:));

    E = R - Y;

    IAE = sum(abs(E));
    ISE = sum(E.^2);
    ITAE = sum(abs(E).*T);
    J(x,1) = nthroot(IAE*ISE*ITAE, 3); %MEDIA GEOMETRICA
end