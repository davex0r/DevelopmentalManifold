%%
xmodmap -e "add control = Super_L"
%% Fit the data with logistic function
clear
clc
load('celData_673.mat')
fits_raw = fit_logistic(cel_data,'fit_type','raw');
figure
scatter3(fits_raw(:,1),fits_raw(:,2),fits_raw(:,3),10,'filled')
%% Fit the data with logistic function with length and time normalized to egg-laying
clc
fits_norm = fit_logistic(cel_data,'fit_type','norm');
figure
scatter3(fits_norm(:,1),fits_norm(:,2),fits_norm(:,3),10,'filled')
%%
t_laid = nan(length(cel_data),1);
l_laid = t_laid;
t_dev = t_laid;
for i = 1:length(cel_data)
    [~,~,t_laid(i),l_laid(i),t_dev(i)] = get_devDuration(cel_data,i);
end
clear i
%% Plot thte error between the scaled fit from raw data and the fit from the normalized data
figure
fits_scaled = fits_raw.*[1./l_laid t_laid 1./t_laid];
err = sqrt(sum((fits_scaled-fits_norm).^2,2));
plot(err)
%%
dims = [1 2 3];
indx = err<0.01&~isnan(t_dev)&t_dev<4000;
plot3(fits_scaled(indx,dims(1)),fits_scaled(indx,dims(2))',fits_scaled(indx,dims(3))','.')
hold on
plot3(fits_norm(indx,dims(1)),fits_norm(indx,dims(2)),fits_norm(indx,dims(3)),'o')
%%
fits_scaled = fits_raw.*[1./l_laid t_laid 1./t_laid];
plot3(fits_scaled(indx,1),fits_scaled(indx,2)',fits_scaled(indx,3)','.')
hold on
plot3(fits_norm(indx,1),fits_norm(indx,2),fits_norm(indx,3),'o')
set(gca,'fontsize',14,'fontweight','bold')
xlabel('\boldmath$\hat{l}$','Interpreter','latex')
ylabel('\boldmath$\hat{r}$','Interpreter','latex')
zlabel('\boldmath$\hat{A}$','Interpreter','latex')
box on
legend({'fit to raw, adjusted','fit to rescaled'},'Location','north')

%% Add the ex-utero development time 
t_utero = minutes(duration([cel_data.t_hatched]-[cel_data.t_laid]))';
%% Combine the raw data
raw_data = [fits_raw(indx,:) t_laid(indx)];
[scaled_raw_data, raw_mean, raw_std] = center_scale(raw_data);
%% Combine the normalized data
norm_data = [fits_norm(indx,:) t_laid(indx)];
[scaled_norm_data, norm_mean, norm_std] = center_scale(raw_data);
%%
l_hatch = nan(673,1);
for i = 1:length(cel_data)
    l_hatch(i) = median([cel_data(i).time_series.wormlength(1:20)]*cel_data(i).scale);
end
%%
histogram(sqrt(sum((fits_scaled(indx,:)-fits_norm(indx,:)).^2,2)))
set(gca,'fontsize',14,'fontweight','bold')
xlabel('MSE')
ylabel('Counts')