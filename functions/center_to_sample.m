function [data_sample, sample_mean, sample_std, stats] = center_to_sample(data,indx,i,j,n_perms)

if size(indx,2) ==3
    tmp_indx = cum_to_lin(indx,i,j);
else
    tmp_indx = indx;
end

tmp_data = data(tmp_indx,:);
[data_sample, sample_mean, sample_std] = center_scale(tmp_data);

if ~isempty(n_perms)
    stats = regstats(data_sample(:,n_perms(1)),data_sample(:,n_perms(2)),'linear','beta');
else
    stats = [];
end

end