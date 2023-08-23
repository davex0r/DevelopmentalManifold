function plot_normalization(cel_data,ax)

if isempty(ax)
    ax(1) = subplot(1,2,1);
    ax(2) = subplot(1,2,2);
end
to_plot = [62 127 505 441];
tmp_cel = cel_data(to_plot);
[~, new_co] = init_color;
axes(ax(1))
for k = 1:length(tmp_cel)
    [t_elapsed, wormlength] = get_devDuration(tmp_cel,k,'l_est','fit');
    plot(t_elapsed,wormlength/1000,'.')
    hold on
end
xlabel('\boldmath$t \hspace{3mm} [min]$','Interpreter','latex','FontSize',18)
ylabel('\boldmath$l \hspace{3mm} [mm]$','Interpreter','latex','FontSize',18)
set(gca,'FontSize',14,'Fontweight','bold')
for k = 1:length(tmp_cel)
    [~, ~, tmp_t_laid, tmp_l_laid] = get_devDuration(tmp_cel,k,'l_est','fit');
    plot(tmp_t_laid,tmp_l_laid/1000,'ks','MarkerFaceColor','w','MarkerSize',10)
    plot(tmp_t_laid,tmp_l_laid/1000,'ks','MarkerFaceColor',new_co(k,:),'MarkerSize',5)
    legend_entry{k} = [tmp_cel(k).strain ':' tmp_cel(k).bacteria]
end
legend(legend_entry,'fontsize',9)
axes(ax(2))
for k = 1:length(tmp_cel)
    [t_elapsed, wormlength, tmp_t_laid, tmp_l_laid] = get_devDuration(tmp_cel,k,'l_est','fit');
    plot(t_elapsed/tmp_t_laid,wormlength/tmp_l_laid,'.')
    hold on
end
xlabel('\boldmath$\hat{t} \hspace{3mm} [1]$','Interpreter','latex','FontSize',18)
ylabel('\boldmath$\hat{l} \hspace{3mm} [1]$','Interpreter','latex','FontSize',18)
set(gca,'FontSize',14,'Fontweight','bold','ylim',[0.15 1.3],'xlim',[0 1.65])
