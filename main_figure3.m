function void = main_figure3(void)

clear all; close all; clc; 

filename = 'GI3_attack_final'
load(filename);
plot(vacc_rate_list*100, annual_attack_rate_GI3, 'LineWidth', 2); hold on;
xlabel('vaccine coverage (%)'); ylabel('annual attack rate (%)')
xlim([0 100])
ylim([0 12])

filename = 'GII4_attack_final'
load(filename);
plot(vacc_rate_list*100, annual_attack_rate_GII4, 'LineWidth', 2); 

filename = 'GI3_GII4_attack_final'
load(filename);
plot(vacc_rate_list*100, annual_attack_rate_GI3_GII4, 'LineWidth', 2)

filename = 'GI3_GII3_GII4_attack_final'
load(filename);
plot(vacc_rate_list*100, annual_attack_rate_GI3_GII3_GII4, 'LineWidth', 2, 'LineStyle', ':')

filename = 'GII2_GII3_GII4_attack_final'
load(filename);
plot(vacc_rate_list*100, annual_attack_rate_GII2_GII3_GII4, 'LineWidth', 2)

filename = 'GII2_GII3_GII4_GII6_attack_final'
load(filename);
plot(vacc_rate_list*100, annual_attack_rate_GII2_GII3_GII4_GII6, 'LineWidth', 2, 'LineStyle', ':')

filename = 'GI3_GII2_GII3_GII4_GII6_attack_final'
load(filename);
plot(vacc_rate_list*100, annual_attack_rate_GI3_GII2_GII3_GII4_GII6, 'LineWidth', 2)

legend('GI.3 vaccine', 'GII.4 vaccine', 'GI.3/GII.4 vaccine', 'GI.3/GII.3/GII.4 vaccine', 'GII.2/GII.3/GII.4 vaccine', 'GII.2/GII.3/GII.4/GII.6 vaccine', 'GI.3/GII.2/GII.3/GII.4/GII.6 vaccine')
