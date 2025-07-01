function void = main_figureS3(void)

clear all; close all; clc; 

filename = 'NoV_noVaccine'

load(filename);

figure(1); subplot(1,4,1); 
bar(params.age_classes, params.N_age_class, 'FaceColor','k','EdgeColor','none','LineWidth',1)
N_total = sum(params.N_age_class);
xlabel('age'); ylabel('# individuals');

t = t';

for i = 1:length(t)
    [S_array, T_array, I_array, cumI_array] = UnVectorizeData(y(i,:)', params);
      
    outcome.n_infecteds(i) = sum(sum(sum(I_array)));
    outcome.pop_size(i) = sum(sum(sum(I_array))) + sum(sum(S_array)) + sum(sum(T_array));
    outcome.cum_infecteds(i) = sum(sum(sum(cumI_array))); % includes all individuals who have been infected (whether vacc or no vacc)
    
    outcome.n_infectedsByGeno(1:params.n, i) = reshape(sum(sum(I_array,2),1), params.n, 1);
    outcome.cum_infectedsByGeno(1:params.n, i) = reshape(sum(sum(cumI_array,2),1), params.n, 1);
end

subplot(1,4,2); 
for sero = 1:params.n
    plot(t,outcome.n_infectedsByGeno(sero,:)); hold on;
end
plot(t,outcome.n_infecteds, 'k'); ylabel('# infected'); hold on;
legend('GI.3', 'GII.2', 'GII.3', 'GII.4', 'GII.6', 'overall')
xlabel('years prior to vaccination')
xlim([-20 0]); ylim([0 14e5])

[annual_t, annual_attack_rate] = GetAnnualIncidencePer100000(t, outcome.cum_infecteds, outcome.pop_size);
attack_rate_display = 100*annual_attack_rate(end)/100000
subplot(1,4,3); 
for geno = 1:params.n
    [annual_t_geno, annual_attack_geno] = GetAnnualIncidencePer100000(t, outcome.cum_infectedsByGeno(geno,:), outcome.pop_size);
    annual_attack_rate_byGeno(geno,:) = annual_attack_geno;
    attack_rate_percent(geno,:) = 100*annual_attack_rate_byGeno(geno,:)/100000;
    plot(annual_t_geno,attack_rate_percent(geno,:)); hold on;
end
plot(annual_t, 100*annual_attack_rate/100000, 'k'); ylabel('annual attack rate (%)'); hold on;
xlabel('years prior to vaccination')
xlim([-20 0]); ylim([0 12]);

x = 0;
subplot(1,4,4); bar(x, attack_rate_percent(:,end)', "stacked")
xticks([0]); xticklabels({'no vaccination'})
ylim([0 12]);
