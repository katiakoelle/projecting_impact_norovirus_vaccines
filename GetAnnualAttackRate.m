function annual_attack_rate_final = GetAnnualAttackRate(filename)

load(filename);

t_post = t';
y_post = y;

for i = 1:length(t_post)

    [S_array, T_array, I_array, cumI_array] = UnVectorizeData(y_post(i,:)', params);
      
    outcome.n_infecteds(i) = sum(sum(sum(I_array)));
    outcome.pop_size(i) = sum(sum(sum(I_array))) + sum(sum(S_array)) + sum(sum(T_array));
    outcome.cum_infecteds(i) = sum(sum(sum(cumI_array))); % includes all individuals who have been infected (whether vacc or no vacc)
    
    outcome.n_infectedsByGeno(1:params.n, i) = reshape(sum(sum(I_array,2),1), params.n, 1);
    outcome.cum_infectedsByGeno(1:params.n, i) = reshape(sum(sum(cumI_array,2),1), params.n, 1);

end

[annual_t, annual_attack_rate] = GetAnnualIncidencePer100000(t_post, outcome.cum_infecteds, outcome.pop_size);
annual_attack_rate_final = 100*annual_attack_rate(end)/100000;
