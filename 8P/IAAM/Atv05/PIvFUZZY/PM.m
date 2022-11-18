%% Process
% Use this scrip to simulate a given parametric model to control. 
%% Author
% Gilberto Reynoso Meza (ORCid 0000-0002-8392-6225)
% @gilreyme
% http://www.researchgate.net/profile/Gilberto_Reynoso-Meza
% Version: Jun/2020

function dY=P(~,Y)

y=PM_dX_SphericalTank(Y(1:end-1),Y(end));

dY=[y;0];

%% ODE function
function dY=PM_dX_SphericalTank(X,U)

%% ODE variables
h=X(1);  % liquid evel in the tank
qi=U(1); % Position of the motor-driven valve [0 - 1] = [closed fully-open]

%% Reality constraints
if h<=0+0.001
    h=0.001;
end

if h>=2-0.001
    h=2-0.001;
end

if qi>1
    qi=1;
end

if qi<0
    qi=0;
end

%% Model parameters
R=1.0;   % Inner radius of the spherical tank [m]
Cp=0.05; % Constant of the outlet valve [m^2]
g=9.81;  % Gravitational acceleration [m/s^2]

%% Computing states

h_dt=(qi)/(pi*(2*R*h-h*h))-(Cp*sqrt(2*g*h))/(pi*(2*R*h-h*h));  %eq. 69

%% Updating states
dY=[h_dt];

if isnan(dY)
    dY=0;
end