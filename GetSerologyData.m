function [serology_any, serology_by_geno] = GetSerologyData(S_array_index, T_array_index, params, ssinfo)

uninfected_array = S_array_index + T_array_index;
n_by_age = sum(uninfected_array,2);

for a = 1:params.n_age_classes
    serology_in_age = 0;
    for h = 1:(2^params.n)
        hist = ssinfo(h).strain_history;
        if ~isempty(hist)
            serology_in_age = serology_in_age + uninfected_array(a,h);
        end
    end
    serology_any(a,1) = serology_in_age/n_by_age(a);
end

for geno = 1:params.n
    for a = 1:params.n_age_classes
        serology_of_geno_in_age = 0;
        for h = 1:(2^params.n)
            hist = ssinfo(h).strain_history;
            if ismember(geno, hist)
                serology_of_geno_in_age = serology_of_geno_in_age + uninfected_array(a,h);
            end
        end
        serology_by_geno(a,geno) = serology_of_geno_in_age/n_by_age(a);
    end
end

