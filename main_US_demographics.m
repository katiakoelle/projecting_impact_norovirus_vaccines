function void = main_US_demographics(void)

% survivorship data from:
% https://www.cdc.gov/nchs/data/nvsr/nvsr54/nvsr54_14.pdf
% probabilities of dying (in 2003)

clear all; close all; clc;

ages = (0:100)';

prob_dying = [
0.006865
0.000469
0.000337
0.000254
0.000194
0.000177
0.000160
0.000147
0.000132
0.000117
0.000109
0.000118
0.000157
0.000233
0.000339
0.000460
0.000577
0.000684
0.000769
0.000832
0.000894
0.000954
0.000990
0.000997
0.000982
0.000960
0.000942
0.000936
0.000947
0.000974
0.001008
0.001046
0.001097
0.001162
0.001244
0.001336
0.001441
0.001567
0.001714
0.001874
0.002038
0.002207
0.002389
0.002593
0.002819
0.003064
0.003322
0.003589
0.003863
0.004148
0.004458
0.004800
0.005165
0.005554
0.005971
0.006423
0.006925
0.007496
0.008160
0.008927
0.009827
0.010831
0.011872
0.012891
0.013908
0.015003
0.016267
0.017699
0.019320
0.021108
0.022950
0.024904
0.027151
0.029784
0.032753
0.035831
0.038987
0.042503
0.046557
0.051200
0.056335
0.061837
0.067856
0.074504
0.081975
0.089682
0.098031
0.107059
0.116804
0.127300
0.138581
0.150676
0.163611
0.177408
0.192080
0.207636
0.224075
0.241387
0.259552
0.278539
1.00000
];

surv_probs = (1-prob_dying);

perc_age_class = (1/length(ages))*ones(length(ages),1);

for i = 1:10000
    new_perc_age_class = perc_age_class.*surv_probs;
    new_perc_age_class(end) = [];
    new_perc_age_class = [0; new_perc_age_class];
    new_perc_age_class(1) = 1-sum(new_perc_age_class);
    perc_age_class = new_perc_age_class;
end
plot(ages, new_perc_age_class)

params_demog.maxLifespan = max(ages);
params_demog.age_incr = 1;
params_demog.age_classes = ages;
params_demog.n_age_classes = length(ages);

params_demog.N = 290.1*1e6  % 290.1 million
params_demog.perc_age_class = new_perc_age_class;
params_demog.surv_probs = surv_probs;

params_demog.N_age_class = params_demog.N*params_demog.perc_age_class;

save('US_demographics_2003', 'params_demog');