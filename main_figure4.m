function void = main_figure4(void)

clear all; close all; clc; 

filename_pre = 'NoV_noVaccine';

filename_post = 'NoV_GI3_vacc80';
figure4_plot(filename_pre, filename_post, 1);

filename_post = 'NoV_GII4_vacc80';
figure4_plot(filename_pre, filename_post, 2);

filename_post = 'NoV_GI3_GII2_GII3_GII4_GII6_vacc80';
figure4_plot(filename_pre, filename_post, 3);
