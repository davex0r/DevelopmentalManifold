% names = {'wt','isol','mut'};
% out_table = table;
% for i = 1:3
%     out_table.(names{i}+"h") = out{i,1};
%     out_table.(names{i}+"xi") = out{i,2};
% end
% writetable(out_table,'Fig5D.csv')
%
data = readtable("Fig5D.csv");

old_co = [0 0 1;
0 0.5 0;
1 0 0;
0 0.75 0.75;
0.75 0 0.75;
0.75 0.75 0;
0.25 0.25 0.25];

symbols = 's>do<^';
names = {'wt','isol','mut'};
for i = 1:3
    plot(data.(names{i}+"h"),data.(names{i}+"xi"),[symbols(i) '-'],'linewidth',1,'color',old_co(i,:));
    hold on
end
xlabel('\boldmath$pdf(\phi_3)$','Interpreter','latex','FontSize',18)
ylabel('\boldmath$\phi_3$','Interpreter','latex','FontSize',18)
set(gca,'xdir','reverse','xlim',[0 18])
legend(names,'location','northwest')
