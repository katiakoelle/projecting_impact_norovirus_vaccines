function y = VectorizeData(S_array, T_array, I_array, cumI_array, params)

y_S = reshape(S_array, params.n_age_classes*(2^params.n), 1);

y_T = reshape(T_array, params.n_age_classes*(2^params.n), 1);

y_I = reshape(I_array, params.n_age_classes*(2^params.n)*params.n, 1, 1);
y_cumI = reshape(cumI_array, params.n_age_classes*(2^params.n)*params.n, 1, 1);

y = [y_S; y_T; y_I; y_cumI];
