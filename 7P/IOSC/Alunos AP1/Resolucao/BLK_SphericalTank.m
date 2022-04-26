%% ODE-Model template to run using simulink
% This function implements the parametric model of a Spherical tank
% process as a block in simulink.
%
%% Author
% Gilberto Reynoso Meza (ORCid 0000-0002-8392-6225)
% @gilreyme
% http://www.researchgate.net/profile/Gilberto_Reynoso-Meza
% Version: Apr/2019
%

%% Template structure for a SIMULINK block
% t -> time
% x -> states (column); must match with derivatives in 'sys'.
% u -> input/inputs to the system.
%
function [sys,x0,str,ts] = BLK_SphericalTank(t,x,u,flag)

switch flag,
case 0
 [sys,x0,str,ts]=mdlInitializeSizes; % Initialization
case 1
 sys = mdlDerivatives(t,x,u); % Calculate derivatives
 case 3
 sys = mdlOutputs(t,x,u); % Calculate outputs

case { 2, 4, 9 } % Unused flags
sys = [];
otherwise
 error(['Unhandled flag = ',num2str(flag)]); % Error handling
end

function [sys,x0,str,ts] = mdlInitializeSizes
%% mdlInitializeSizes;
sizes = simsizes;
sizes.NumContStates = 1;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 1;
sizes.NumInputs = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);

x0 = [0]'; % Initial conditions.

str = []; % str is an empty matrix.

ts = [0 0]; % Initialize the array of sample times

function sys = mdlDerivatives(t,x,u)
%% mdlDerivatives; Here it comes our ODE parametric model (ODE-PM).

dY=PM_dX_SphericalTank(x,u);

sys=dY;

function sys = mdlOutputs(t,x,u)
%% mdlOutputs; send the measurable signal to the output block.
sys = x(1);

if sys>2
    sys=2;
end

if sys<0
    sys=0;
end

sys=sys+0.001*randn;  %
