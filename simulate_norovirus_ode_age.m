function dydt = simulate_norovirus_ode_age(t, y, params, ssinfo, ssinfo_recovered_loc)

[S_array, T_array, I_array, cumI_array] = UnVectorizeData(y, params);
   
N_size = sum(sum(S_array)) + sum(sum(T_array)) + sum(sum(sum(I_array)));

dS_array = zeros(size(S_array)); 
dT_array = zeros(size(T_array));
dI_array = zeros(size(I_array)); 
dcumI_array = zeros(size(cumI_array));

% count cumulative infections upon recovery
dcumI_array = params.v*I_array; 

% infecteds, summed across age classes:
I_array_by_genotype_ageless = reshape(sum(sum(I_array, 1),2), params.n, 1);
% first, compute force of infection for each genotype:
seas = 1 - params.eps*cos(2*pi*t);
lambdaVals = params.immigration + seas*(params.beta_const').*I_array_by_genotype_ageless;

% let's do S first: 
% S increases with births (NOT INCLUDED HERE; included in IncrementAgeClasses), 
% S decreases with new infections
% S increases with T -> S
dS_array_infections = zeros(size(S_array)); 
for cg = 1:params.n
    this_susc_level_matrix = repmat(params.susc_level(cg,:), params.n_age_classes, 1);
    dS_array_infections = dS_array_infections - lambdaVals(cg)*this_susc_level_matrix.*S_array/params.N;
end
dS_array_waning = params.delta*T_array;
dS_array = dS_array_infections + dS_array_waning;

% now let's do T: 
% when there is xImm, 
% T decreases with T -> S
% T increases with I -> T
% T increases or decreases with T -> T when there is clinical cross-protection (not yet implemented!!)
dT_array_waning = -params.delta*T_array;
dT_array_recovery = zeros(size(T_array)); 
% cycle through infecting genotypes:
for i = 1:params.n
    I_array_by_genotype = I_array(:,:,i);
    for j = 1:(2^params.n)
        locInT = ssinfo_recovered_loc(i,j);
        dT_array_recovery(:,locInT) = dT_array_recovery(:,locInT) + params.v*I_array_by_genotype(:,j);
    end
end
dT_array = dT_array_waning + dT_array_recovery;

% now let's do I: 
% I decreases with I -> T
% I increases with S -> I
dI_array_recovery = -params.v*I_array;
dI_array_infection = zeros(size(I_array)); 
for cg = 1:params.n
    this_susc_level_matrix = repmat(params.susc_level(cg,:), params.n_age_classes, 1);
    dI_array_infection(:,:,cg) = dI_array_infection(:,:,cg) + lambdaVals(cg)*this_susc_level_matrix.*S_array/params.N;
end
dI_array = dI_array_recovery + dI_array_infection;

dydt = VectorizeData(dS_array, dT_array, dI_array, dcumI_array, params);
