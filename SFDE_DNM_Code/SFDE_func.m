function [Mse, rMse, Mape, Mae, R, Convergence, target_data, output_data, Mset, rMset, Mapet, Maet, Rt] = SFDE_func(F_index,divide_rate,MaxIt,popsize,kcz,mcz,qcz)

[ trainx, trainy, testx, testy, denNumber ] = divideDataset( F_index, divide_rate,mcz);       % divide the dataset into two subpopulation

[input_train, st1] = mapminmax(trainx,0.3,0.7);
[target_train, st2] = mapminmax(trainy,0.3,0.7);
input_test = mapminmax('apply',testx,st1);  % Make "Testing data" be normalized just the same as that with "Training data".
target_test = mapminmax('apply',testy,st2);

Xmin=-5;
Xmax=5;

k=kcz;
qs=qcz;
M=denNumber;
D=2*M*size(input_train,1);

% Maximum iteration number
Max_iteration= 2 * MaxIt;

convergence=[];
F = 0.7;          % scaling factor
CR = 0.9;         % crossover control parameter

% random initialization for agents.
pop = repmat(Xmin, popsize, D) + rand(popsize, D) .* (repmat((Xmax - Xmin), popsize, D));

% Evaluation of agents.
fit = evolution_fitness(input_train, target_train, pop, M,k,qs);

% BA Settings
Mp=3;
Ba=ScaleFree(popsize,Mp);

for ite = 1:Max_iteration
    
    % index_nox: indices for binomial crossover
    index_nox = 1 : popsize;
    
    V = pop;              % V: the set of mutant vectors
    U = pop;              % U: the set of trial vectors
    fit_U = fit;          % fit_U: the set of objective function values of trial vectors
    
    % sor the population
    [fit,idx]=sort(fit);
    Newpop = pop(idx,:);  pop=Newpop;
    
    % Choose k randomly, not equal to i
    kop =zeros(1,popsize);
    for ppp=1:popsize
        KLLe = ceil(rand(1)*Ba(ppp).Dd);
        kop(ppp) = Ba(ppp).Sec(KLLe);
    end
    
    %%%%%%%%%%%%%%%%%%%     mutation       %%%%%%%%%%%%%%%%%%%%%%%%
    
    % Get indices for mutation
    [r1, r2, r3] = getindex(popsize);
    
    % Implement DE/rand/1 mutation
    V = pop(r1, :) + F * (pop(r2, :) - pop(r3, :)) + rand(popsize, D) .* (pop(kop, :) - pop(r1, :));
    
    % Check whether the mutant vector violates the boundaries or not
    V = boundConstraint(V,Xmin,Xmax);
    
    %%%%%%%%%%%%%%%%%%%     crossover       %%%%%%%%%%%%%%%%%%%%%%%
    
    for i = 1:length(index_nox)
        j_rand = floor(rand * D) + 1;
        t = rand(1, D) < CR;
        t(1, j_rand) = 1;
        t_ = 1 - t;
        U(index_nox(i), :) = t .* V(index_nox(i), :) + t_ .* pop(index_nox(i), :);
        fit_U(index_nox(i)) = evolution_fitness(input_train, target_train, U(index_nox(i), :), M,k,qs);
    end
    
    %%%%%%%%%%%%%%%%%%%       selection      %%%%%%%%%%%%%%%%%%%%%%%%
    
    % Select the better one between the target vector and its trial vector
    for i = 1:popsize
        if fit_U(i) <= fit(i)
            pop(i, :) = U(i, :);
            fit(i) = fit_U(i);
        end
    end
    convergence = [convergence, min(fit)];
    
end

Convergence = convergence/2;

[fit,idx]=sort(fit);
Newpop = pop(idx,:);

[Error_train,output_train] = evolution_fitness( input_train, target_train, Newpop(1,:),M,k,qs);

ypt = mean(target_train);
opt = mean(output_train);

Mset = mean((output_train'-target_train).^2);
rMset = (Mset)^0.5;
Mapet = sum(abs((target_train-output_train')/target_train))/length(target_train);
Maet = sum(abs((target_train-output_train' )))/length(target_train);
Rt = sum(abs((target_train-ypt).*(output_train'-opt)))/(sum(abs((target_train-ypt).*(target_train-ypt)))*sum(abs((output_train'-opt).*(output_train'-opt))))^0.5;

output_data01 = mapminmax('reverse', output_train', st2);


[Error_test,output_test] = evolution_fitness( input_test, target_test, Newpop(1,:),M,k,qs);
output_data02 = mapminmax('reverse', output_test', st2);

yp = mean(target_test);
op = mean(output_test);

Mse = mean((output_test'-target_test).^2);
rMse = (Mse)^0.5;
Mape = sum(abs((target_test-output_test')/target_test))/length(target_test);
Mae = sum(abs((target_test-output_test')))/length(target_test);
R = sum(abs((target_test-yp).*(output_test'-op)))/(sum(abs((target_test-yp).*(target_test-yp)))*sum(abs((output_test'-op).*(output_test'-op))))^0.5;

target_data=[trainy testy];

output_data=[output_data01 output_data02];
