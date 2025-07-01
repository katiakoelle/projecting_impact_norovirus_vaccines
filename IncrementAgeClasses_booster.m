function [S_array, T_array, I_array, params] = IncrementAgeClasses_booster(S_array, T_array, I_array, params, ssinfo, ssinfo_recovered, ssinfo_recovered_loc)

deaths_by_age_class = (1-params.surv_probs).*params.N_age_class;
total_births = sum(deaths_by_age_class);

surv_matrix = repmat(params.surv_probs, 1, 2^params.n);

% update arrays for mortalities:
S_array = surv_matrix.*S_array;
T_array = surv_matrix.*T_array;
for i = 1:params.n
    I_array(:,:,i) = surv_matrix.*I_array(:,:,i);
end

% now shift age classes: 
S_array(params.n_age_classes,:) = [];
S_array = [zeros(1, 2^params.n); S_array];

T_array(params.n_age_classes,:) = [];
T_array = [zeros(1, 2^params.n); T_array];

I_array(params.n_age_classes,:,:) = [];
I_array = [zeros(1, 2^params.n, params.n); I_array];

% calculate number of individuals in each age class:

% if vaccination scenario, vaccinate here!
S_array(1,1) = total_births*(1-params.vaccine_coverage_births);
T_array(1,params.vacc_loc) = total_births*params.vaccine_coverage_births; % into temporarily immune state

if params.vaccine_coverage_booster > 0
    locs = (params.vaccine_coverage_booster_age + 1)';
    temp_S_array_row = S_array(locs,:)*params.vaccine_coverage_booster;
    temp_T_array_row = T_array(locs,:)*params.vaccine_coverage_booster;
    S_array(locs,:) = S_array(locs,:)*(1-params.vaccine_coverage_booster); % keep the individuals in their spots if not getting boosted
    T_array(locs,:) = T_array(locs,:)*(1-params.vaccine_coverage_booster); % keep the individuals in their spots if not getting boosted

    % figure out where the boosted individuals go!
    for hist = 1:(2^params.n)
        new_strain_history = ssinfo(hist).strain_history;
        for vacc_strain = 1:params.n
            if params.vaccine(vacc_strain) % if in the vaccine
                new_strain_history = union(new_strain_history, vacc_strain);
            end
        end

        for map_loc = 1:(2^params.n)
            if isequal(ssinfo(1,map_loc).strain_history, new_strain_history)
                this_loc = map_loc;
                break;
            end
        end
        T_array(locs,map_loc) = T_array(locs,map_loc) + temp_T_array_row(:,hist) + temp_S_array_row(:,hist);
    end
end

params.N_age_class = sum(S_array,2) + sum(T_array, 2) + sum(sum(I_array, 3), 2);
