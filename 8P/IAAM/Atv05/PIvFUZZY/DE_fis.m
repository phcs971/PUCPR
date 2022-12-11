%% Differential Evolution template

%% Parameters:

% About the PM and the CF.
CF = str2func('CF_fis');
NVar = 19;
Pop = 20;
UpperLimit = [ 0  0 0 1 1  0  0 0 1 1  1  1  1  1  1  1  1  1  1];
LowerLimit = [-2 -2 0 0 0 -2 -2 0 0 0 -1 -1 -1 -1 -1 -1 -1 -1 -1];
DeltaLimit = UpperLimit - LowerLimit;

% About the algorithm.
F = 0.5;
Cr = 0.9;
Generations = 100;

%% Algorithm 

% Generate a random population of Parents within bounds (size=(Pop,Nvar))

for pop=1:Pop
   Parent(pop,:) = rand(1, 19) .* DeltaLimit + LowerLimit; 
end

% Check their performance (CF)

for pop=1:Pop
    ParentCF(pop,1) = CF(Parent(pop,:));
end

% Enter the BIG loop

for generations=1:Generations
    % Generate "Pop" Mutant vector accordingly (size=(Pop,Nvar))
    for pop=1:Pop
        idx = randperm(Pop);
        p1 = Parent(idx(1),:);
        p2 = Parent(idx(2),:);
        p3 = Parent(idx(3),:);
        Mutant(pop,:) = p1 + F * (p2 - p3);
    end
    
    % Check limits
    for pop=1:Pop
        for nvar=1:NVar
            Mutant(pop, nvar) = max(min(Mutant(pop, nvar), UpperLimit(nvar)), LowerLimit(nvar));
        end
    end

    % Generate Child vectors accordingly (size=(Pop,Nvar))
    for pop=1:Pop
        for nvar=1:NVar
            if rand() < Cr
                Child(pop, nvar) = Mutant(pop, nvar);
            else
                Child(pop,nvar) = Parent(pop, nvar);
            end
        end
    end
    
    %Check limits
    
    %Evaluate Child population performance
    for pop=1:Pop
        ChildCF(pop,1) = CF(Child(pop,:));
    end
    
    % Compare Parent and Child objective vector to create new Parents;
    for pop=1:Pop
        if ParentCF(pop, 1) <= ChildCF(pop, 1)
            NewParent(pop,:) = Parent(pop, :);
            NewParentCF(pop,:) = ParentCF(pop, :);
        else
            NewParent(pop,:) = Child(pop,:);
            NewParentCF(pop,:) = ChildCF(pop, :);
        end
    end
    
    % Replace Parents with NewParents
    Parent=NewParent;
    ParentCF=NewParentCF;
    
    % Check termination criteria
    if generations>=Generations
        break;
    end
    
    display(num2str(generations))
end

%% Gimme My Result

idx = find(ParentCF == min(ParentCF));
idx = idx(1);
X = Parent(idx,:)
ParentCF(idx,:)

[R, Y, U, T] = PM_fis(X(1,:));

stairs(T, Y); hold on;
stairs(T, U); hold on;
plot(T, R); grid on;
legend("Output", "Control", "Reference")
xlabel("Time (s)")
ylabel("Valve Position (-)")
title("Fuzzy")