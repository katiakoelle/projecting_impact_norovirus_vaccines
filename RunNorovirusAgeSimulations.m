function void = RunNorovirusAgeSimulations(params, tStart, tEnd)

params.beta_const = params.R0_geno*params.v;        % transmission rate

[ssinfo, ssinfo_recovered, ssinfo_recovered_loc] = CreateStrainHistoryStructure(params);

vacc_hist = [];
for i = 1:params.n
    if params.vaccine(i) == 1
        vacc_hist = union(vacc_hist, i);
    end
end
for map_loc = 1:(2^params.n)
    if isequal(ssinfo(1,map_loc).strain_history, vacc_hist)
        this_loc = map_loc;
        break;
    end
end
params.vacc_loc = this_loc;

% this is an (n genotypes) x (2^n) matrix that has the susceptibility levels, as a function of previous infection history, if challenged
params.susc_level = GetSusceptibilityLevelFromHazards(params, ssinfo);

[S_array, I_array, T_array, cumI_array] = GetInitialArrays(params, ssinfo);

y_init = VectorizeData(S_array, T_array, I_array, cumI_array, params);

t = tStart; y = y_init';
t_yr = []; t_cntr = Inf; tic
 
while 1
    
    tFinal = tStart + params.age_incr; % simulate until the next age increment.
    
    t_cntr = t_cntr + params.age_incr;
    
    [t_append, y_append] = ode45(@(t,y)simulate_norovirus_ode_age(t, y, params, ssinfo, ssinfo_recovered_loc), [tStart:params.dt:tFinal], y_init); % still have to do
    
    t = [t; t_append(2:end)];
    y = [y; y_append(2:end,:)];
   
    [S_array, T_array, I_array, cumI_array] = UnVectorizeData(y_append(end,:)', params);

    [S_array, T_array, I_array, params] = IncrementAgeClasses_booster(S_array, T_array, I_array, params, ssinfo, ssinfo_recovered, ssinfo_recovered_loc);
    
    y_init = VectorizeData(S_array, T_array, I_array, cumI_array, params);
    
    if t_cntr > 1   % just to see things moving...
        tFinal
        t_cntr = 0;
        toc
    end
    
    tStart = tFinal;
    
    if tFinal >= tEnd
        break;
    end

end

save(params.filename, 'params', 't', 'y', 'ssinfo');
