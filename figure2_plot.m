function void = figure2_plot(filename, i, j, k, l)

load(filename);

difference_time = 1;
[S_array, T_array, I_array, cumI_array] = UnVectorizeData(y(end,:)', params);
cum_infectedsByAge_end(:, 1) = sum(sum(cumI_array,2),3);
locs = find(t <= (t(end)-difference_time));
loc_start = locs(end);
[S_array, T_array, I_array, cumI_array] = UnVectorizeData(y(loc_start,:)', params);
cum_infectedsByAge_start(:, 1) = sum(sum(cumI_array,2),3);
difference_NoV = (cum_infectedsByAge_end - cum_infectedsByAge_start);
annual_attackRate_by_age = 100*(difference_NoV/difference_time)./params.N_age_class;

propInAgeClass = difference_NoV/sum(difference_NoV);
subplot(4,4,i); bar(params.age_classes, propInAgeClass, 'FaceColor','k', 'EdgeColor','none', 'BarWidth', 1);
if i == 1
    hold on; plot(params.age_classes, params.N_age_class./sum(params.N_age_class), 'r')
    ylabel('proportion of cases');
end
xlim([0 100]); ylim([0 0.025]);

if i == 1
    title('No vaccine');
elseif i == 2
    title('GI.3 vaccine');
elseif i == 3
    title('GII.4 vaccine');
elseif i == 4
    title('GI.3/GII.2/GII.3/GII.4/GII.6 vaccine');
end

subplot(4,4,j); bar(params.age_classes, annual_attackRate_by_age, 'FaceColor','k', 'EdgeColor','none', 'BarWidth', 1)
if j == 5
    ylabel('annual attack rate (%)')
end
xlim([0 100]); ylim([0 20]);

% serology plot
t_index = length(t)-1;
[S_array_index, T_array_index, I_array_index, cumI_array_index] = UnVectorizeData(y(t_index,:)', params);
[serology_any, serology_by_geno] = GetSerologyData(S_array_index, T_array_index, params, ssinfo);

subplot(4,4,k); 
plot(params.age_classes, [zeros(1,5); serology_by_geno(1:(end-1),:)], 'LineWidth', 2); hold on;
plot(params.age_classes, [0; serology_any(1:(end-1))], 'k:', 'LineWidth', 2); hold on;
if k == 9
    ylabel('proportion seropositive')
end
xlim([0 100]); ylim([-0.01 1]);

subplot(4,4,l); 
infectedsByAge_byGeno = reshape(sum(I_array_index,2), params.n_age_classes, params.n);
for i = 1:params.n_age_classes
    freq_infectedsByAge_byGeno(i,:) = infectedsByAge_byGeno(i,:)./sum(infectedsByAge_byGeno(i,:));
end
bar(params.age_classes, freq_infectedsByAge_byGeno, 'stacked', 'EdgeColor','none', 'BarWidth', 1);
 
xlabel('age (yrs)'); 
if l == 13
    ylabel('genotype frequency')
end
xlim([0 100]); ylim([0 1]);
if l == 16
    legend('GI.3', 'GII.2', 'GII.3', 'GII.4', 'GII.6')
end