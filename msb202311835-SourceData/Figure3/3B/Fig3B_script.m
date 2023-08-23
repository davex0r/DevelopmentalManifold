labels = {'lhat','rhat','Ahat','tdev','thatch','lhatch','llaid'};
data_out = table;
for i = 1:length(labels)
    data_out.("mean_"+labels{i})=out{1}(:,i)
    data_out.("std_"+labels{i})=out{2}(:,i)
end
writetable(data_out,'Fig3B.csv')
% % 
clear
labels = {'lhat','rhat','Ahat','tdev','thatch','lhatch','llaid'};
data=readtable("Fig3B.csv");
k = [1 2];
x = data.("mean_"+labels{k(1)});
y = data.("mean_"+labels{k(2)});
z1 = data.("std_"+labels{k(1)});
z2 = data.("std_"+labels{k(2)});
stats = regstats(x,y,'linear','beta');

    new_co = [ 0    0.4470    0.7410
0.8500    0.3250    0.0980
0.9290    0.6940    0.1250
0.4940    0.1840    0.5560
0.4660    0.6740    0.1880
0.3010    0.7450    0.9330
0.6350    0.0780    0.1840];

names = {'AB1','N2','PS2025','Sid','C28'};
foods = {'HB101','DA1877','BPumilus','PFragi'};
for i = 1:length(names)
    for j = 1:length(foods)
        n = (i-1)*length(foods)+j;
        errorbar(x(n),y(n),z2(n),z2(n),z1(n),z1(n),'color',new_co(j,:),'linewidth',2)
        hold on
    end
end
[top_int, bot_int, X, Y] = regression_line_ci(.05,stats.beta,x,y,100,-4,4);
plot(X,Y,'color','r','LineWidth',2);
plot(X,top_int,'green--','LineWidth',1);
plot(X,bot_int,'green--','LineWidth',1);
set(gca,'xlim',[-4 4],'ylim',[-4 4])
axis square
xlabel(labels(k(1)),'Interpreter','latex')
ylabel(labels(k(2)),'Interpreter','latex')
