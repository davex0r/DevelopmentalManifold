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
len_data =readtable('Fig2B_length.csv');
dev_data =readtable('Fig2B_dev.csv');

new_co = [ 0    0.4470    0.7410
0.8500    0.3250    0.0980
0.9290    0.6940    0.1250
0.4940    0.1840    0.5560
0.4660    0.6740    0.1880
0.3010    0.7450    0.9330
0.6350    0.0780    0.1840];

for i = 1:4
plot(len_data.("example"+i+"t_elapsed")/dev_data.("example"+i+"t_laid")...
    ,len_data.("example"+i+"wormlength")/dev_data.("example"+i+"l_laid"),'.','color',new_co(i,:))
hold on
end
xlabel('\boldmath$\hat{t} \hspace{3mm} [1]$','Interpreter','latex','FontSize',18)
ylabel('\boldmath$\hat{l} \hspace{3mm} [1]$','Interpreter','latex','FontSize',18)
set(gca,'FontSize',14,'Fontweight','bold','ylim',[0.15 1.3],'xlim',[0 1.65])


