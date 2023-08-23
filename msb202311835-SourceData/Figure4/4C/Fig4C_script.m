% names = {'AB1','N2','PS2025'};
% out_table = table;
% for i = 1:3
%     out_table.(names{i}+"h") = out{i,1};
%     out_table.(names{i}+"xi") = out{i,2};
% end
% writetable(out_table,'Fig4C.csv')
% %
data = readtable("Fig4C.csv");
symbols = 's>do<^';
names = {'AB1','N2','PS2025'};
for i = 1:3
    plot(out_table.(names{i}+"h"),out_table.(names{i}+"xi"),[symbols(i) '-'],'linewidth',1,'color',[0.5 0.5 0.5]);
    hold on
end
xlabel('\boldmath$pdf(\phi_2)$','Interpreter','latex','FontSize',18)
ylabel('\boldmath$\phi_2$','Interpreter','latex','FontSize',18)
set(gca,'xdir','reverse','xlim',[0 12])
legend(names,'location','northwest')
