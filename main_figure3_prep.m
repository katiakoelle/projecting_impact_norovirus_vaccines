function void = main_figure3_prep(void)

clear all; close all; clc; 
filename_pre = 'NoV_GI3_GII2_GII3_GII4_GII6_vacc';
cntr = 1; vacc_rate_list = 0:0.01:1;
for vacc_rate = vacc_rate_list
    vacc_rate
    filename = strcat(filename_pre, int2str(vacc_rate*100));
    annual_attack_rate(cntr) = GetAnnualAttackRate(filename);
    cntr = cntr + 1;
    annual_attack_rate_GI3_GII2_GII3_GII4_GII6 = annual_attack_rate;
    save('GI3_GII2_GII3_GII4_GII6_attack_final', 'vacc_rate_list', 'annual_attack_rate_GI3_GII2_GII3_GII4_GII6')
end

clear all; close all; clc; 
filename_pre = 'NoV_GI3_GII3_GII4_vacc';
cntr = 1; vacc_rate_list = 0:0.01:1;
for vacc_rate = vacc_rate_list
    vacc_rate
    filename = strcat(filename_pre, int2str(vacc_rate*100));
    annual_attack_rate(cntr) = GetAnnualAttackRate(filename);
    cntr = cntr + 1;
    annual_attack_rate_GI3_GII3_GII4 = annual_attack_rate;
    save('GI3_GII3_GII4_attack_final', 'vacc_rate_list', 'annual_attack_rate_GI3_GII3_GII4')
end

clear all; close all; clc; 
filename_pre = 'NoV_GI3_GII4_vacc';
cntr = 1; vacc_rate_list = 0:0.01:1;
for vacc_rate = vacc_rate_list
    vacc_rate
    filename = strcat(filename_pre, int2str(vacc_rate*100));
    annual_attack_rate(cntr) = GetAnnualAttackRate(filename);
    cntr = cntr + 1;
    annual_attack_rate_GI3_GII4 = annual_attack_rate;
    save('GI3_GII4_attack_final', 'vacc_rate_list', 'annual_attack_rate_GI3_GII4')
end

clear all; close all; clc; 
filename_pre = 'NoV_GI3_vacc';
cntr = 1; vacc_rate_list = 0:0.01:1;
for vacc_rate = vacc_rate_list
    vacc_rate
    filename = strcat(filename_pre, int2str(vacc_rate*100));
    annual_attack_rate(cntr) = GetAnnualAttackRate(filename);
    cntr = cntr + 1;
    annual_attack_rate_GI3 = annual_attack_rate;
    save('GI3_attack_final', 'vacc_rate_list', 'annual_attack_rate_GI3')
end

clear all; close all; clc; 
filename_pre = 'NoV_GII2_GII3_GII4_GII6_vacc';
cntr = 1; vacc_rate_list = 0:0.01:1;
for vacc_rate = vacc_rate_list
    vacc_rate
    filename = strcat(filename_pre, int2str(vacc_rate*100));
    annual_attack_rate(cntr) = GetAnnualAttackRate(filename);
    cntr = cntr + 1;
    annual_attack_rate_GII2_GII3_GII4_GII6 = annual_attack_rate;
    save('GII2_GII3_GII4_GII6_attack_final', 'vacc_rate_list', 'annual_attack_rate_GII2_GII3_GII4_GII6')
end

clear all; close all; clc; 
filename_pre = 'NoV_GII2_GII3_GII4_vacc';
cntr = 1; vacc_rate_list = 0:0.01:1;
for vacc_rate = vacc_rate_list
    vacc_rate
    filename = strcat(filename_pre, int2str(vacc_rate*100));
    annual_attack_rate(cntr) = GetAnnualAttackRate(filename);
    cntr = cntr + 1;
    annual_attack_rate_GII2_GII3_GII4 = annual_attack_rate;
    save('GII2_GII3_GII4_attack_final', 'vacc_rate_list', 'annual_attack_rate_GII2_GII3_GII4')
end

clear all; close all; clc; 
filename_pre = 'NoV_GII4_vacc';
cntr = 1; vacc_rate_list = 0:0.01:1;
for vacc_rate = vacc_rate_list
    vacc_rate
    filename = strcat(filename_pre, int2str(vacc_rate*100));
    annual_attack_rate(cntr) = GetAnnualAttackRate(filename);
    cntr = cntr + 1;
    annual_attack_rate_GII4 = annual_attack_rate;
    save('GII4_attack_final', 'vacc_rate_list', 'annual_attack_rate_GII4')
end
