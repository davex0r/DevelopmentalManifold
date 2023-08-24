% names = {'AB1','N2','PS2025','sid2','C28'};
% out_table = table;
% for i = 1:5
%     out_table.(names{i}+"h") = out{i,1};
%     out_table.(names{i}+"xi") = out{i,2};
% end
% writetable(out_table,'Fig5B.csv')
% %
data = readtable("Fig5B.csv");

old_co = [0 0 1;
0 0.5 0;
1 0 0;
0 0.75 0.75;
0.75 0 0.75;
0.75 0.75 0;
0.25 0.25 0.25];

symbols = 's>do<^';
names = {'AB1','N2','PS2025','sid2','C28'};
for i = 1:3
    plot(data.(names{i}+"h"),data.(names{i}+"xi"),[symbols(i) '-'],'linewidth',1,'color',[0.5 0.5 0.5]);
    hold on
end
for i= 4:5
    plot(data.(names{i}+"h"),data.(names{i}+"xi"),['-'],'linewidth',1,'color',old_co(i,:));
end
xlabel('\boldmath$pdf(\phi_2)$','Interpreter','latex','FontSize',18)
ylabel('\boldmath$\phi_2$','Interpreter','latex','FontSize',18)
set(gca,'xdir','reverse','xlim',[0 18])
legend(names,'location','northwest')
