%% Differential Evolution template

%% Parameters:

% About the PM and the CF.
CF = str2func('MyCF');
NVar =              % Number of decision variables;
Pop =               % Population. Number of random vectors; --> Entre 5 y 10 veces el num de variables
UpperLimit =        % Upper limit for each variable; Row-vector format;
LowerLimit =        % Lower limit for each variable; Row-vector format;

% About the algorithm.
F =                 % Scaling Factor; Entre 0.1 y 1; Hay quien dice que hasta 2.
Cr =                % Crossover rate; Entre 0.1 y 1.
Generations =       % Stop criteria;

%% Algorithm 

% Generate a random population of Parents within bounds (size=(Pop,Nvar))

for pop=1:Pop
    
    Parent(pop,:) =
    
end

% Check their performance (CF)

for pop=1:Pop
    
    ParentCF(pop,1) = CF(Parent(pop,:));
    
end

% Enter the BIG loop

for generations=1:Generations

    % Generate "Pop" Mutant vector accordingly (size=(Pop,Nvar))
    for pop=1:Pop
    
        Mutant(pop,:) = 
    
    end
    
    % Check limits
    
    % Generate Child vectors accordingly (size=(Pop,Nvar))
    for pop=1:Pop
   
        Child(pop,:) = 
    
    end
    
    %Check limits
    
    %Evaluate Child population performance
    for pop=1:Pop
        
        ChildCF(pop,1) = CF(Child(pop,:));
        
    end
    
    % Compare Parent and Child objective vector to create new Parents;
    for pop=1:Pop
        if 
            NewParent(pop,:)=
            NewParentCF(pop,:)=
        else
            NewParent(pop,:)=
            NewParentCF(pop,:)=
        end
    end
    
    % Replace Parents with NewParents
    Parent=NewParent;
    ParentCF=NewParentCF;
    
    % Check termination criteria
    if generations>=Generations
        break;
    end
    
end

%% Gimme My Result