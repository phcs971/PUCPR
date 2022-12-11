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

function [J,X]=CF_fis(X,~)
    J=zeros(size(X,1),1);
    
    for x=1:size(X,1)
        [R,Y,~,T] = PM_fis(X(x,:));
    
        % Fixing
        X(x,1:5)=sort(X(1,1:5));
        X(x,6:10)=sort(X(1,6:10));
        
        E = R - Y;
        
        IAE = sum(abs(E));
        ISE = sum(E.^2);
        ITAE = sum(abs(E).*T);
        
        J(x,1) = nthroot(IAE*ISE*ITAE, 3); %MEDIA GEOMETRICA 
    end
end