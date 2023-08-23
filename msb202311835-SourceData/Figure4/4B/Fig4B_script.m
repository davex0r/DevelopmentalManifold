% names = {'E. coli','C. aquatica','B. pumilus','P. fragi'};
% out_table = table;
% for i = 1:4
%     out_table.(names{i}+"h") = out{i,1};
%     out_table.(names{i}+"xi") = out{i,2};
% end
% writetable(out_table,'Fig4B.csv')
% %%
data = readtable("Fig4B.csv");

    new_co = [ 0    0.4470    0.7410
0.8500    0.3250    0.0980
0.9290    0.6940    0.1250
0.4940    0.1840    0.5560
0.4660    0.6740    0.1880
0.3010    0.7450    0.9330
0.6350    0.0780    0.1840];

symbols = 's>do<^';
names = {'E. coli','C. aquatica','B. pumilus','P. fragi'};
table_names = {'E_Coli','C_Aquatica','B_Pumilus','P_Fragi'};
for i = 1:4
    plot(data.(table_names{i}+"xi"),data.(table_names{i}+"h"),'linewidth',2,'color',new_co(i,:));
    hold on
end
ylabel('\boldmath$pdf(\phi_1)$','Interpreter','latex','FontSize',18)
xlabel('\boldmath$\phi_1$','Interpreter','latex','FontSize',18)
legend(names,'location','northeast')
