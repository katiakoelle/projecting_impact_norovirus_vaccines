function void = main_norovirus_GI3_GII2_GII3_GII4_GII6_vacc80_withBooster(void)

clear all; close all; tic

tBegin = 0; tEnd = 500;

load('US_demographics_2003'); % note: assuming constant population size

params = params_demog;

% ------ PARAMETERS --------------------------------------------------------------
% all considered in units of years (or years^-1)

params.n = 5;                       % GI.3, GII.2, GII.3, GII.4, GII.6

% basic reproduction numbers for the genotypes considered
params.R0_geno = [2.4 2.3 2.5 2.4 1.3]; % this is pretty good

% time in model is in units of years or years^-1
avg_duration_infection_days = 14;
params.v = 1/(avg_duration_infection_days/365.25);       % recovery rate

params.eps = 0;                 % seasonality coefficient

params.immigration = 0.0002*params.N; % rate of new infections: per genotype, per year - to stabilize dynamics!

% rows are previous infections; columns are challenging genotype
params.hazards = [0.35 0.89 0.89 1 1; 1 0.74 1 1 1; 1 1 0.74 1 1; 0.52 0.41 0.41 0.39 0.91; 1 1 1 0.96 0.52]; % this is from Chabbra et al., with values > 1 set to 1

avg_duration_immunity_months = 9; % duration of immunity in months
avg_duration_immunity_days = 365.25*(avg_duration_immunity_months/12);  % 9 months duration of immunity
params.delta = 1/(avg_duration_immunity_days/365.25);   % rate of waning temporary immunity

% simulate model in continuous time but get numerical solutions at monthly time intervals (= 1/12 of a year)
params.dt = 1/12;

% vaccination scenario: GI.3, GII.2, GII.3, GII.4, GII.6
params.vaccine = [1 1 1 1 1]; % GI.3 vaccine!
params.vaccine_coverage_births = 0.80;
params.vaccine_coverage_booster = 0.40;
params.vaccine_coverage_booster_age = 60:100;

params.filename = 'NoV_GI3_GII2_GII3_GII4_GII6_vacc80_withBooster_fig5';
params.infile = 'NoV_noVaccine';

RunNorovirusAgeSimulations(params, tBegin, tEnd);

