% out_data = table;
% out_data.tsim = t_sim';
% for i = 1:length(phi1r)
%     out_data.("phi1_ex_"+i)=phi1r{i}';
%     out_data.("phi2_ex_"+i)=phi2r{i}';
% end
% out_data
% writetable(out_data,'Fig4F.csv')
% %
figure
new_colors = colormap(winter(length(phi1)));
colororder(new_colors);

data = readtable("Fig4F.csv");
for i = 1:5
    plot(data.tsim,data.("phi1_ex_"+i))
    hold on
end
axis([0 4000 0 1200])
xlabel('\boldmath$t [min]$','Interpreter','latex','Fontsize',18)
ylabel('\boldmath$l [\mu m]$','Interpreter','latex','Fontsize',18)

ax(1) = axes;
ax(1).Position = [0.15 0.65 0.15 0.2];
ax(1).CLim = [-0.3 0.3];
colorbar(ax(1),'Location','north')
text(0.5,1.1,'\boldmath$\phi_1$','Interpreter','latex','FontSize',18)
ax(1).Visible='off';
