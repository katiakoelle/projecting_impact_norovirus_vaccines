function susc_level = GetSusceptibilityLevelFromHazards(params, ssinfo)

susc_level = ones(params.n, 2^params.n);

for h = 1:(2^params.n)
    hist = ssinfo(h).strain_history;
    for cg = 1:params.n         % challenging genotype
        for pg = 1:params.n     % possibly previously infecting genotypes
            if ismember(pg, hist)
                susc_level(cg,h) = susc_level(cg,h)*params.hazards(pg,cg);
            end
        end
    end
end
