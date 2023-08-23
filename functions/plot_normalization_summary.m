function plot_normalization_summary(cel_data,t_laid,l_laid,ax)

if isempty(ax)
    figure
else
axes(ax)
end

t_norm = linspace(0.01,1.3,50);

for n = 1:length(cel_data)
    [t_elapsed, wormlength] = get_devDuration(cel_data,n,'l_est','fit');
    x = interp1(t_elapsed/t_laid(n),wormlength/l_laid(n),t_norm,'linear');
    interp_norm(:,n) = x;
    t_hat = mean(t_laid);
    l_hat = mean(l_laid);
    x = interp1(t_elapsed/t_hat,wormlength/l_hat,t_norm,'linear');
    interp_raw(:,n) = x;
end

t = t_norm;
x = mean(interp_raw,2,'omitnan')';
z1 = x+std(interp_raw,[],2,'omitnan')';
z2 = x-std(interp_raw,[],2,'omitnan')';

p = patch([t fliplr(t) t(1)],[z1 fliplr(z2) z1(1)],'red');
hold on
p.FaceAlpha = 0.2;
p.EdgeColor = 'none';
plot(t,x,'r')

x = mean(interp_norm,2,'omitnan')';
z1 = x+std(interp_norm,[],2,'omitnan')';
z2 = x-std(interp_norm,[],2,'omitnan')';

p = patch([t fliplr(t) t(1)],[z1 fliplr(z2) z1(1)],'black');
p.FaceAlpha = 0.2;
p.EdgeColor = 'none';
plot(t,x,'k')
set(gca,'fontsize',18,'fontweight','bold','xlim',[0 1.5])
axis tight
xlabel('\boldmath$\hat{t} \hspace{3mm} [1]$','Interpreter','latex','FontSize',18,'FontWeight','bold')
ylabel('\boldmath$\hat{l} \hspace{3mm} [1]$','Interpreter','latex','FontSize',18,'FontWeight','bold')
legend({'raw (normalized)','', 'rescaled',''},'fontsize',9,'Location','northwest')
box on