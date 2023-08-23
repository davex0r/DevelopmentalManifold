%%
clear
cel_data = [];
files = dir('./singleWorm_data/*.mat');
for i = 1:length(files)
    a = load(['./singleWorm_data/' files(i).name]);
    cel_data = [cel_data a.cel_data];
end
clear a i files
%% Clean outlier length and area data
for i = 1:length(cel_data)
    outlier_indx = cel_data(i).time_series.wormlength<50|cel_data(i).time_series.wormlength>500|cel_data(i).time_series.Area>1.5e4;
    n_outliers(i) = sum(outlier_indx);
    t_start(i) = hours(datetime(cel_data(i).time_series.time(1,:),'TimeZone','Europe/London')-cel_data(i).t_hatched);
    pre_hatch_indx = hours(datetime(cel_data(i).time_series.time,'TimeZone','Europe/London')-cel_data(i).t_hatched)<0;
    clean_indx = (outlier_indx|pre_hatch_indx);
    cel_data(i).time_series(clean_indx,:) = [];
end
plot(t_start)
hold on
plot(n_outliers)

clear i n_outliers clean_indx t_start outlier_indx pre_hatch_indx
%%
names = {'AB1','N2','PS2025','Sid','C28'};
foods = {'HB101','DA1877','BPumilus','PFragi'};
for i = 1:length(names)
    for j = 1:length(foods)
        indx = cellfun(@(x,y) contains(x,names{i})&contains(y,foods{j}),{cel_data.strain},{cel_data.bacteria});
        if sum(indx)>0
            cum_indx_linear(indx,1:3)=[i*ones(sum(indx),1) j*ones(sum(indx),1) (1:sum(indx))'];
        end
    end
end
clear i j indx
%%
save celData_673.mat 