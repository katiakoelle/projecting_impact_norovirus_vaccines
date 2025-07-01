function [S_array, T_array, I_array, cumI_array] = UnVectorizeData(y, params)

y_S = y(1:params.n_age_classes*(2^params.n));
S_array = reshape(y_S, params.n_age_classes, 2^params.n);
y(1:params.n_age_classes*(2^params.n)) = [];

y_T = y(1:params.n_age_classes*(2^params.n));
T_array = reshape(y_T, params.n_age_classes, 2^params.n);
y(1:params.n_age_classes*(2^params.n)) = [];

y_I = y(1:(params.n_age_classes*(2^params.n)*params.n));
I_array = reshape(y_I, params.n_age_classes, 2^params.n, params.n);
y(1:(params.n_age_classes*(2^params.n)*params.n)) = [];

y_cumI = y(1:(params.n_age_classes*(2^params.n)*params.n));
cumI_array = reshape(y_cumI, params.n_age_classes, 2^params.n, params.n);
y(1:(params.n_age_classes*(2^params.n)*params.n)) = [];

