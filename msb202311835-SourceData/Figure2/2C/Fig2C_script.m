% t_norm = linspace(0.01,1.3,50);
% 
% for n = 1:length(cel_data)
%     [t_elapsed, wormlength] = get_devDuration(cel_data,n,'l_est','fit');
%     x = interp1(t_elapsed/t_laid(n),wormlength/l_laid(n),t_norm,'linear');
%     interp_norm(:,n) = x;
%     t_hat = mean(t_laid);
%     l_hat = mean(l_laid);
%     x = interp1(t_elapsed/t_hat,wormlength/l_hat,t_norm,'linear');
%     interp_raw(:,n) = x;
% end
% data = table;
% data.t = t_norm;
% data.x_raw_mean = mean(interp_raw,2,'omitnan');
% data.x_raw_std = std(interp_raw,[],2,'omitnan');
% data.x_norm_mean =  mean(interp_norm,2,'omitnan');
% data.x_norm_std =  std(interp_norm,[],2,'omitnan');
% %
data = readtable('Fig2C.csv');

t = data.t';
x = data.x_raw_mean';
z1 = (data.x_raw_mean+data.x_raw_std)';
z2 = (data.x_raw_mean-data.x_raw_std)';
p = patch([t fliplr(t) t(1)],[z1 fliplr(z2) z1(1)],'red');
hold on
p.FaceAlpha = 0.2;
p.EdgeColor = 'none';
plot(t,x,'r')

t = data.t';
x = data.x_norm_mean';
z1 = (data.x_norm_mean+data.x_norm_std)';
z2 = (data.x_norm_mean-data.x_norm_std)';
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