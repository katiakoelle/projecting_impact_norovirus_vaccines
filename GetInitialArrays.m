function [S_array, I_array, T_array, cumI_array] = GetInitialArrays(params, ssinfo)

if ~isempty(params.infile)
    
    load(params.infile)

    [S_array, T_array, I_array, cumI_array] = UnVectorizeData(y(end,:), params);

    return;

end

annual_fraction_of_pop_dying = sum((1-params.surv_probs).*params.perc_age_class);
approx_per_capita_birth_rate = annual_fraction_of_pop_dying;

    % initialize arrays:
S_array = zeros(params.n_age_classes, 2^params.n);
T_array = zeros(params.n_age_classes, 2^params.n);
I_array = zeros(params.n_age_classes, 2^params.n, params.n);

% to initialize, set initial conditions to approx value for a single-strain system
if min(params.R0_geno) < 0
    error('all R0 values need to exceed 0');
end

% jiggle the R0 values to start off at slightly different initial conditions!!
R0_geno_jiggle = params.R0_geno.*(1+0.001*rand(1,params.n));
if min(R0_geno_jiggle) < 0
    error('all R0 values need to exceed 0');
end
beta_const_jiggle = R0_geno_jiggle*params.v;

Shat_prop_by_geno = 1./R0_geno_jiggle;
Ihat_prop_by_geno = (approx_per_capita_birth_rate./beta_const_jiggle).*(R0_geno_jiggle - 1);
Rhat_prop_by_geno = 1-Ihat_prop_by_geno-Shat_prop_by_geno;

for i = 1:params.n_age_classes
    I_array(i, 1, 1:params.n) = (Ihat_prop_by_geno')*params.N_age_class(i);
end

for hist = 1:(2^params.n)
    h = ssinfo(hist).strain_history;
    propWithHist = 1;
    for g = 1:params.n
        if ismember(g,h)    % then take Rhat_prop_by_geno
            propWithHist = propWithHist*Rhat_prop_by_geno(g);
        else
            propWithHist = propWithHist*Shat_prop_by_geno(g);
        end
    end
    for i = 1:params.n_age_classes
        S_array(i,hist) = propWithHist*params.N_age_class(i);
    end
end

cumI_array = zeros(size(I_array));

