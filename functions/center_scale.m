function [cs_data, data_mean, data_std] = center_scale(data)
data_mean = mean(data,'omitnan');
data_std = std(data,'omitnan');
cs_data = (data-data_mean)./data_std;