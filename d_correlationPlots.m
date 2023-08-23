%% Plot each sample correlation along with mean correlation for each sample
clc
clear
load working_data_withPCA_230116.mat
combined_data = center_scale([fits_raw(indx,:) t_laid(indx) t_utero(indx) l_laid(indx) l_hatch(indx)]);
%%
set(0,'DefaultFigureWindowStyle','normal')
xspan = 11; yspan = 11;
nperSpan = 60;
figure(1)
clf
set(gcf,'pos',[600 50 nperSpan*[xspan yspan]]);
locs = [];
locs(1,:) = [1 6 4 4];
locs(2,:) = [6 6 4 4];
locs(3,:) = [1 1 4 4];
locs(4,:) = [6 1 4 4];

locs = bsxfun(@rdivide,locs,[xspan yspan xspan yspan]);
ax = gobjects(size(locs,1),1);
for i = 1:size(locs,1)
    ax(i) = axes;
    ax(i).Position = locs(i,:);
end

plot_correlations(combined_data,names,foods,cum_indx_linear,indx,...
    'pub','on','perms',[1 2],'ax',ax([1 2]));

plot_correlations(combined_data,names,foods,cum_indx_linear,indx,...
    'pub','on','perms',[4 1],'ax',ax([3 4]));                                                                                                                    

for i = 1:length(ax)
    set(ax(i),'fontsize',14,'fontweight','bold','box','on')
end

clear xspan yspan nperSpan locs i ans ax
%%
clc
[r_sq_sample, r_sq_pop]  = plot_correlations(combined_data(:,1:5),names,foods,cum_indx_linear,indx,...
    'pub','off','perms','all');
%%
figure
sm_indx = ~any(isnan(r_sq_sample),2);
errorbar(mean(r_sq_sample(sm_indx,:),'omitnan'),r_sq_pop,0,0,std(r_sq_sample(sm_indx,:)),std(r_sq_sample(sm_indx,:)),'ko','linewidth',2,'MarkerFaceColor','auto')
perms = nchoosek(1:size(combined_data(:,1:5),2),2);
labels = {'\boldmath$\hat{l}$', '\boldmath$\hat{r}$',...
    '\boldmath$\hat{A}$', '\boldmath$\tilde{t}_{dev}$', '\boldmath$\tilde{t}_{hatch}$' ,'\boldmath$\tilde{l}_{hatch}$','\boldmath$\tilde{l}_{laid}$'};
for i = 1:10
    if i==4
        text(mean(r_sq_sample(sm_indx,i),'omitnan')+0.02,r_sq_pop(i)-0.03,['(' labels{perms(i,1)} ',' labels{perms(i,2)} ')'],'interpreter','latex')
    else
        text(mean(r_sq_sample(sm_indx,i),'omitnan')-0.05,r_sq_pop(i)+0.03,['(' labels{perms(i,1)} ',' labels{perms(i,2)} ')'],'interpreter','latex')
    end
end
line([-1 1],[-1 1],'linestyle','--','color','r')
axis([-1 1 -1 1])
xlabel('\boldmath$\rho$ \textbf{(within)}','Interpreter','latex','fontsize',18)
ylabel('\boldmath$\rho$ \textbf{(between)}','Interpreter','latex','fontsize',18)
set(gca,'fontsize',14,'FontWeight','bold')
axis square
clear sm_indx