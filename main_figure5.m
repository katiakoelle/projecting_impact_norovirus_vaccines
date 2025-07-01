function void = main_figure5(void)

clear all; close all; clc; 

filename = 'NoV_noVaccine'
figure2_plot(filename, 1, 5, 9, 13)

filename = 'NoV_GI3_vacc80_withBooster_fig5'
figure2_plot(filename, 2, 6, 10, 14)

filename = 'NoV_GII4_vacc80_withBooster_fig5'
figure2_plot(filename, 3, 7, 11, 15)

filename = 'NoV_GI3_GII2_GII3_GII4_GII6_vacc80_withBooster_fig5'
figure2_plot(filename, 4, 8, 12, 16)

