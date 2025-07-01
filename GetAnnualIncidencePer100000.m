function [annual_t, annual_attack_rate] = GetAnnualIncidencePer100000(tList, nov_cumulativeList, N_list)

t_yr_floor = floor(tList);
tList_yr = unique(t_yr_floor);
tList_yr(end) = [];

annual_attack_rate = [];
annual_t = [];
for t = tList_yr
    locs = intersect(find(tList >= t), find(tList < (t+1)));

    difference_NoV = nov_cumulativeList(locs(end)) - nov_cumulativeList(locs(1));
    difference_time = tList(locs(end)) - tList(locs(1));
    annual_incidence = (difference_NoV/difference_time)*100000/mean(N_list(locs));
    
    annual_t = [annual_t t];
    annual_attack_rate = [annual_attack_rate; annual_incidence];
    
end
