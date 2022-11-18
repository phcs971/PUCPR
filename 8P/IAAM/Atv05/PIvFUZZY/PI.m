%% PROPORTIONAL-INTEGRAL CONTROLLER
% This script implements a Proportional-Integral controller 
%% Author
% Gilberto Reynoso Meza (ORCid 0000-0002-8392-6225)
% @gilreyme
% http://www.researchgate.net/profile/Gilberto_Reynoso-Meza
% Version: Apr/2019

function uk=PI(r,y,Tuning)

% Introduce persistent parameters
persistent Ie;
if isempty(Ie)
    Ie = 0;
end

ek=r-y;

% Reading control parameters
if nargin==2
    Tuning=ReadTuning('PI');
end

kp=Tuning(1);
Ti=Tuning(2);
Ts=Tuning(3);

% Proportional term
ukp=kp*ek;

% Integral term
ki=(kp/Ti);
uki=ki*(Ie+ek*Ts);

% Computing control action
uk=ukp+uki;
if uk>1
    uk=1;
elseif uk<0
    uk=0;
end

% Updating global parameters
Ie=Ie+ek*Ts;