%% Differential Evolution template

clc;
clear;
close all;

%% Hyper-Parameters:

% About the PM and the CF.

CF=str2func('fc_PI');
NVar = 2;              % Number of decision variables;
Pop = 50;              % Population. Number of random vectors; --> Entre 5 y 10 veces el num de variables
UpperLimit = [5 1000]; % Upper limit for each variable; Row-vector format;
LowerLimit = [0 0];    % Lower limit for each variable; Row-vector format;

% About the algorithm.
F = 0.5;               % Scaling Factor; Entre 0.1 y 1; Hay quien dice que hasta 2.
Cr = 0.9;              % Crossover rate; Entre 0.1 y 1.
Generations = 100;     % Stop criteria;

%% Algorithm 

% Generate a random population of Parents within bounds (size=(Pop,Nvar))

for pop=1:Pop
    
    Parent(pop,1) = UpperLimit(1)*rand;
    Parent(pop,2) = UpperLimit(2)*rand;
    
end

% Check their performance (CF)

for pop=1:Pop
    
    ParentCF(pop,1) = CF(Parent(pop,1),Parent(pop,2));
    
end

% Enter the BIG loop

for generations=1:Generations

    % Generate "Pop" Mutant vector accordingly (size=(Pop,Nvar))
    for pop=1:Pop
        idx = randperm(Pop);
        Mutant(pop,:) = Parent(idx(1),:) + F * ...
            (Parent(idx(2),:) - Parent(idx(3),:));
    
    end
    
    % Check limits
    
    for pop=1:Pop
        for nvar=1:NVar
            if Mutant(pop,nvar) > UpperLimit(nvar)
                Mutant(pop,nvar) = UpperLimit(nvar);
            end
            if Mutant(pop,nvar) < LowerLimit(nvar)
                Mutant(pop,nvar) = LowerLimit(nvar);
            end
        end
    end

    % Generate Child vectors accordingly (size=(Pop,Nvar))
    for pop=1:Pop
        for nvar=1:NVar
            if rand < Cr
                Child(pop,nvar) = Mutant(pop,nvar);
            else
                Child(pop,nvar) = Parent(pop,nvar);
            end
        end
    end
    
    %Check limits
    
    %Evaluate Child population performance
    for pop=1:Pop
        
        ChildCF(pop,1) = CF(Child(pop,1),Child(pop,2));
        
    end
    
    % Compare Parent and Child objective vector to create new Parents;
    for pop=1:Pop
        if ParentCF(pop,1) <= ChildCF(pop,1)
            NewParent(pop,:) = Parent(pop,:);
            NewParentCF(pop,:) = ParentCF(pop,:);
        else
            NewParent(pop,:) = Child(pop,:);
            NewParentCF(pop,:) = ChildCF(pop,:);
        end
    end
    
    % Replace Parents with NewParents
    Parent=NewParent;
    ParentCF=NewParentCF;
    
    % Check termination criteria
    if generations>=Generations
        break;
    end
    display(num2str(generations));
end

%% Gimme My Result

idx = find(ParentCF==min(ParentCF));
PI = Parent(idx,:)
Result = ParentCF(idx,:)