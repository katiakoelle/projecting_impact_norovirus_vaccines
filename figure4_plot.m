function void = figure4_plot(filename_pre, filename_post, plot_loc)

load(filename_pre);

t_pre = t'; y_pre = y;

load(filename_post);

t_post = t'; y_post = y;

for i = 1:length(t_pre)

    [S_array, T_array, I_array, cumI_array] = UnVectorizeData(y_pre(i,:)', params);
      
    outcome.n_infecteds(i) = sum(sum(sum(I_array)));
    outcome.pop_size(i) = sum(sum(sum(I_array))) + sum(sum(S_array)) + sum(sum(T_array));
    outcome.cum_infecteds(i) = sum(sum(sum(cumI_array))); % includes all individuals who have been infected (whether vacc or no vacc)
    
    outcome.n_infectedsByGeno(1:params.n, i) = reshape(sum(sum(I_array,2),1), params.n, 1);
    outcome.cum_infectedsByGeno(1:params.n, i) = reshape(sum(sum(cumI_array,2),1), params.n, 1);

end
for j = 1:length(t_post)

    [S_array, T_array, I_array, cumI_array] = UnVectorizeData(y_post(j,:)', params);
      
    outcome.n_infecteds(i+j) = sum(sum(sum(I_array)));
    outcome.pop_size(i+j) = sum(sum(sum(I_array))) + sum(sum(S_array)) + sum(sum(T_array));
    outcome.cum_infecteds(i+j) = sum(sum(sum(cumI_array))); % includes all individuals who have been infected (whether vacc or no vacc)
    
    outcome.n_infectedsByGeno(1:params.n, i+j) = reshape(sum(sum(I_array,2),1), params.n, 1);
    outcome.cum_infectedsByGeno(1:params.n, i+j) = reshape(sum(sum(cumI_array,2),1), params.n, 1);

end

t_all = [t_pre t_post];

[annual_t, annual_attack_rate] = GetAnnualIncidencePer100000(t_all, outcome.cum_infecteds, outcome.pop_size);
subplot(1,3,plot_loc); 
for geno = 1:params.n
    [annual_t_geno, annual_attack_geno] = GetAnnualIncidencePer100000(t_all, outcome.cum_infectedsByGeno(geno,:), outcome.pop_size);
    annual_attack_rate_byGeno(geno,:) = annual_attack_geno;
    plot(annual_t_geno,100*annual_attack_rate_byGeno(geno,:)/100000, 'LineWidth', 2); hold on;
end
plot(annual_t, 100*annual_attack_rate/100000, 'k:', 'LineWidth', 2); 
if plot_loc == 1
    ylabel('annual attack rate (%)'); 
end
if params.n == 4
    legend('GI.3', 'GII.2', 'GII.3', 'GII.4','all NoV')
elseif params.n == 5
    if plot_loc == 3
        legend('GI.3', 'GII.2', 'GII.3', 'GII.4', 'GII.6', 'all NoV')
    end
end
xlabel('years post vaccination start')
xlim([-50 50]); ylim([0 10]);

if plot_loc == 1
    title('GI.3 vaccine')
elseif plot_loc == 2
    title('GII.4 vaccine')
elseif plot_loc == 3
    title('GI.3/GII.2/GII.3/GII.4/GII.6 vaccine')
end
        
