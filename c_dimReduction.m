%%
clear
load working_data_noPCA.mat
%%
l_hatch = nan(673,1);
for i = 1:length(cel_data)
    l_hatch(i) = median([cel_data(i).time_series.wormlength(1:20)]*cel_data(i).scale);
end
%%
combined_data = center_scale([fits_scaled(indx,:) t_laid(indx) t_utero(indx) l_laid(indx) l_hatch(indx)]);
%% Compute the 3-2d nlpca projection
rng(0)
[c_2d,net_2d,network_2d]=nlpca(scaled_raw_data',2,'type','inverse','max_iteration',3000);
%% Compute the 4-3d nlpca projection
rng(5)
[c_3d,net_3d,network_3d]=nlpca(scaled_raw_data',3,'pre_pca','yes','type','inverse','max_iteration',3000);
%% Plot the embedding colored by condition
[tmp, tmp1] = plot_embedding_output(c_3d,[1 2 3],names,foods,cum_indx_linear(indx,:),t_dev(indx),[])
%% Plot embedding with marginal distributions
ax  = plot_marginal_embed(c_3d, names,foods,cum_indx_linear,t_dev,indx,net_2d);
set(ax(1),'xlim',[-.5 0.5],'ylim',[-0.2 0.3])
set(ax(2),'ylim',[0 10])
set(ax(3),'xlim',[0 12])
for i = 1:4
    set(ax(i),'fontsize',14,'fontweight','bold')
end
ax(5) = axes('Position',[0.74 0.38 0.2 0.1],'Visible','off');
cb = colorbar(ax(5),'Location','north');
set(cb,'Limits',[40 70])
set(ax(5),'Clim',[35 75])
set(gcf,'Renderer','painters')

clear ax i
%% Correlations between phi_2 and t_dev
X = c_3d(1,:)';
X = center_scale(X);
Y = t_laid(indx);
Y = center_scale(Y);
plot(X,Y,'.')
stats = regstats(X,Y,'linear','beta');
[r, p] = plot_regression([X Y],stats)
clear X Y r p stats
%% NLPCA parameter sweep
figure
[scaled_raw_data, raw_mean, raw_std] = center_scale(raw_data);
clc
tmp_n = 5;
tmp_tmax = 4000;
ax(1) = subplot(1,2,1)
phi1 = linspace(-0.3,.3,tmp_n);
phi2 = zeros(size(phi1));
t_sim = linspace(0,tmp_tmax,100);
new_colors = colormap(winter(length(phi1)));
colororder(new_colors);
[~, new_co] = init_color;
for i = 1:length(phi1)
    figure(1)
    tmp = nlpca_get_data(net_3d,[phi1(i); phi2(i); 0]);
%     tmp = (tmp(1:3).*raw_std(1:3)')+raw_mean(1:3)';
    tmp = (tmp.*raw_std')+raw_mean';
%     tmp = tmp(1:3);
%     tmp = tmp(1:3).*[1/logistic(tmp(1:3),tmp(4)) tmp(4) 1/tmp(4)]';
    plot(t_sim,logistic(tmp(1:3),t_sim))
    hold on
    plot(tmp(4),logistic(tmp(1:3),tmp(4)),'o')
    figure(2)
    plot(t_sim/tmp(4),logistic(tmp(1:3),t_sim)/logistic(tmp(1:3),tmp(4)),'--')
    hold on
    phi1r{i} = logistic(tmp(1:3),t_sim);
end
% for j = 1:4
%     tmp_indx = cum_to_lin(cum_indx_linear(indx,:),[],j);
%     tmp1 = c_3d(1,tmp_indx);
%     tmp = nlpca_get_data(net_3d,[mean(tmp1); 0; 0]);
%     tmp = (tmp(1:3).*raw_std(1:3)')+raw_mean(1:3)';
%     plot(t_sim,logistic(tmp,t_sim),'color',new_co(j,:))
%     hold on
% end
figure(1)
axis([0 tmp_tmax 0 1200])
xlabel('\boldmath$t [min]$','Interpreter','latex','Fontsize',18)
ylabel('\boldmath$l [\mu m]$','Interpreter','latex','Fontsize',18)

ax(3) = axes;
ax(3).Position = [0.15 0.65 0.15 0.2];
ax(3).CLim = [min(phi1) max(phi1)];
set(ax(3),'FontSize',24)
colorbar(ax(3),'Location','north')
text(0.5,1.1,'\boldmath$\phi_1$','Interpreter','latex','FontSize',18)
ax(3).Visible='off';
figure(1)
ax(2) = subplot(1,2,2);
phi2 = linspace(-.1,.1,tmp_n);
phi1 = zeros(size(phi1));
for i = 1:length(phi1)
    figure(1)
    tmp = nlpca_get_data(net_3d,[phi1(i); phi2(i); 0]);
    tmp = (tmp.*raw_std')+raw_mean';
%     tmp = tmp(1:3).*[1/logistic(tmp(1:3),tmp(4)) tmp(4) 1/tmp(4)]';
%     tmp = tmp(1:3);
    plot(t_sim,logistic(tmp(1:3),t_sim))
    hold on
    plot(tmp(4),logistic(tmp(1:3),tmp(4)),'o')
    figure(3)
    plot(t_sim/tmp(4),logistic(tmp(1:3),t_sim)/logistic(tmp(1:3),tmp(4)),'--')
    hold on
    phi2r{i} = logistic(tmp(1:3),t_sim);
end
figure(1)
axis([0 tmp_tmax 0 1200])
% for i = 1:4
%     tmp_indx = cum_to_lin(cum_indx_linear(indx,:),[],i);
%     tmp1 = c_3d(1,tmp_indx);
%     tmp = nlpca_get_data(net_3d,[median(tmp1); 0; 0]);
%     tmp = (tmp.*raw_std')+raw_mean';
%     tmp = tmp(1:3).*[1/logistic(tmp(1:3),tmp(4)) tmp(4) 1/tmp(4)]';
%     plot(t_sim,logistic(tmp,t_sim),'color',new_co(i,:))
%     hold on
% end
xlabel('\boldmath$t [min]$','Interpreter','latex','Fontsize',18)
ylabel('\boldmath$l [\mu m]$','Interpreter','latex','Fontsize',18)
ax(4) = axes;
ax(4).Position = [0.6 0.65 0.15 0.2];
ax(4).CLim = [min(phi2) max(phi2)];
set(ax(4),'FontSize',24)
colorbar(ax(4),'Location','north')
text(0.5,1.1,'\boldmath$\phi_2$','Interpreter','latex','FontSize',18)
ax(4).Visible='off';
for i = 1:length(ax)
    set(ax(i),'Fontsize',14,'Fontweight','bold')
end

clear i j i new_colors tmp* ax

%%
ax = axes;
ax.Position = [0.2 0.6 0.2 0.2];
ax.CLim = phi_lims;
set(ax,'FontSize',24)
colorbar(ax,'Location','north')
text(0.5,1.2,'$\phi_2$','Interpreter','latex','FontSize',24)
ax.Visible='off';


