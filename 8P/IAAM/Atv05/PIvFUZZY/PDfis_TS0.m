% Simple 2 input, 1 output FIS
% 9 inference rules.
% Granularity 3.

function uk=PDfis_TS0(r,y,Tuning)

persistent e_old;
if isempty(e_old)
    e_old=0;
end

persistent U
if isempty(U)
    U=0;
end

x1=r-y;
x2=e_old-x1;
e_old=x1;

% Reading control parameters
if nargin==2
    Tuning=ReadTuning('PDfis_TS0');
end

Learning=Tuning;

%% Crisp to Fuzzy


%Variable 1:
Base=sort(Learning(1,1:5));

if x1 <Base(2)
    Mu1_1=1;
elseif x1>=Base(2) && x1<Base(3)
    Mu1_1=(Base(3)-x1)/(Base(3)-Base(2));
else
    Mu1_1=0;
end

if x1<Base(2)
    Mu1_2=0;
elseif x1>=Base(2) && x1<Base(3)
    Mu1_2=(x1-Base(2))/(Base(3)-Base(2));
elseif x1>=Base(3) && x1<Base(4)
    Mu1_2=(Base(4)-x1)/(Base(4)-Base(3));
else
    Mu1_2=0;
end

if x1<Base(3)
    Mu1_3=0;
elseif x1>=Base(3) && x1<Base(4)
    Mu1_3=(x1-Base(3))/(Base(4)-Base(2));
else
    Mu1_3=1;
end

%Variable 2:
Base=sort(Learning(1,6:10));

if x2 <Base(2)
    Mu2_1=1;
elseif x2>=Base(2) && x2<Base(3)
    Mu2_1=(Base(3)-x2)/(Base(3)-Base(2));
else
    Mu2_1=0;
end

if x2<Base(2)
    Mu2_2=0;
elseif x2>=Base(2) && x2<Base(3)
    Mu2_2=(x2-Base(2))/(Base(3)-Base(2));
elseif x2>=Base(3) && x2<Base(4)
    Mu2_2=(Base(4)-x2)/(Base(4)-Base(3));
else
    Mu2_2=0;
end

if x2<Base(3)
    Mu2_3=0;
elseif x2>=Base(3) && x2<Base(4)
    Mu2_3=(x2-Base(3))/(Base(4)-Base(2));
else 
    Mu2_3=1;
end

%% Rule Firing

Rule1=min(Mu1_1,Mu2_1);
Rule2=min(Mu1_1,Mu2_2);
Rule3=min(Mu1_1,Mu2_3);
Rule4=min(Mu1_2,Mu2_1);
Rule5=min(Mu1_2,Mu2_2);
Rule6=min(Mu1_2,Mu2_3);
Rule7=min(Mu1_3,Mu2_1);
Rule8=min(Mu1_3,Mu2_2);
Rule9=min(Mu1_3,Mu2_3);

%% Fuzzy to Crisp

Singleton=Learning(1,11:end);

Crisp  = Rule1*Singleton(1) + ...
         Rule2*Singleton(2) + ...
         Rule3*Singleton(3) + ...
         Rule4*Singleton(4) + ...
         Rule5*Singleton(5) + ...
         Rule6*Singleton(6) + ...
         Rule7*Singleton(7) + ...
         Rule8*Singleton(8) + ...
         Rule9*Singleton(9);
 
Crisp = Crisp / (Rule1 + Rule2 + Rule3 +...
                 Rule4 + Rule5 + Rule6 +...
                 Rule7 + Rule8 + Rule9);

%% Return

U=U+Crisp;
if U>1
    U=1;
elseif U<0
    U=0;
end
uk=U;
