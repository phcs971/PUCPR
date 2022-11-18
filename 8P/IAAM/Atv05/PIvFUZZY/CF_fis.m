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

tfinal=160;
d_T=0.2;

J=zeros(size(X,1),1);

for x=1:size(X,1)

    U(1)=0; % Control action or manual input
    Y(1)=0; % Process response
    R(1)=0; % Reference
    T(1)=0; % Time vector
    
    clear PDfis_TS0
    for t=0:d_T:tfinal
    
        r=sp(t);

        [~,y]=ode45(@PM,[0:d_T:d_T],[Y(end) U(end)]);
    
        u=PDfis_TS0(r,y(end,1),X(x,:));  %Use this to control the system.

        R(end+1)=r;
        Y(end+1)=y(end,1);
        U(end+1)=u;
        T(end+1)=t;
    
    end

    % Fixing
    X(x,1:5)=sort(X(1,1:5));
    X(x,6:10)=sort(X(1,6:10));
    
    J(x,1)=sum(abs(R-Y));

    U=[];
    Y=[];
    T=[];
    R=[];
    


end