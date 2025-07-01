function [ssinfo, ssinfo_recovered, ssinfo_recovered_loc] = CreateStrainHistoryStructure(params)

ssinfo(1).strain_history = [];
cntr = 2;
set = 1:params.n;
for subset = 1:params.n
    combos = nchoosek(set, subset);
    n_combos = size(combos,1);
    for i = 1:n_combos
        ssinfo(1,cntr).strain_history = combos(i,:);
        cntr = cntr + 1;
    end
end

for i = 1:params.n
    for hist = 1:(2^params.n)
        ssinfo_recovered(i,hist).strain_history = union(ssinfo(hist).strain_history, i)
    end
end

for i = 1:params.n
    for hist = 1:(2^params.n)
        % finding the location of the recovered set in the original ssinfo structure
        this_loc = NaN;
        for map_loc = 1:(2^params.n)
            if isequal(ssinfo(1,map_loc).strain_history, ssinfo_recovered(i,hist).strain_history)
                this_loc = map_loc;
                break;
            end
        end
        ssinfo_recovered_loc(i,hist) = this_loc;
    end
end
