% to_plot = [62 127 505 441];
% tmp_cel = cel_data(to_plot);
% for k = 1:length(tmp_cel)
%     [t_elapsed, wormlength, t_laid, l_laid] = get_devDuration(tmp_cel,k,'l_est','fit');
%     t_ela{k} = t_elapsed;
%     wlen{k} = wormlength;
%     c(k) = t_laid;
%     d(k) = l_laid;
% end
% a = nCell2mat(t_ela);
% b = nCell2mat(wlen);
% out_data = table;
% for i = 1:4
%     name0 = "example"+i;
%     out_data.(name0+"t_elapsed") = a(:,i);
%     out_data.(name0+"wormlength") = b(:,i);
% end
% dev_data = table;
% for i = 1:4
%     name0 = "example"+i;
%     dev_data.(name0+"t_laid") = c(i);
%     dev_data.(name0+"l_laid") = d(i);
% end
% % 
len_data =readtable('Fig2A_length.csv');
dev_data =readtable('Fig2A_dev.csv');

new_co = [ 0    0.4470    0.7410
0.8500    0.3250    0.0980
0.9290    0.6940    0.1250
0.4940    0.1840    0.5560
0.4660    0.6740    0.1880
0.3010    0.7450    0.9330
0.6350    0.0780    0.1840];

legend_entry = {'AB1:HB101', 'N2:DA1877', 'PS2025:BPumilus', 'PS2025:HB101'};

for i = 1:4
plot(len_data.("example"+i+"t_elapsed"),len_data.("example"+i+"wormlength")/1000,'.','color',new_co(i,:))
hold on
end
xlabel('\boldmath$t \hspace{3mm} [min]$','Interpreter','latex','FontSize',18)
ylabel('\boldmath$l \hspace{3mm} [mm]$','Interpreter','latex','FontSize',18)
set(gca,'FontSize',14,'Fontweight','bold')
for i = 1:4
    plot(dev_data.("example"+i+"t_laid"),dev_data.("example"+i+"l_laid")/1000,'ks','MarkerFaceColor','w','MarkerSize',10)
    plot(dev_data.("example"+i+"t_laid"),dev_data.("example"+i+"l_laid")/1000,'ks','MarkerFaceColor',new_co(i,:),'MarkerSize',5)
end
legend(legend_entry,'fontsize',9,'Location','northwest')


