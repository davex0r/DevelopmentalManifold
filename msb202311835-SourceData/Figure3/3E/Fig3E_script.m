%%
clear
figure
data = readtable("Fig3E.csv");
x = data.mean_r_sq_sample;
y = data.r_sq_pop;
errorbar(x,y,0,0,data.std_r_sq_sample,data.std_r_sq_sample,'ko','linewidth',2,'MarkerFaceColor','auto')
perms = nchoosek(1:5,2);
labels = {'\boldmath$\hat{l}$', '\boldmath$\hat{r}$',...
    '\boldmath$\hat{A}$', '\boldmath$\tilde{t}_{dev}$', '\boldmath$\tilde{t}_{hatch}$' ,'\boldmath$\tilde{l}_{hatch}$','\boldmath$\tilde{l}_{laid}$'};
for i = 1:10
    if i==4
        text(x(i)+0.02,y(i)-0.03,['(' labels{perms(i,1)} ',' labels{perms(i,2)} ')'],'interpreter','latex')
    else
        text(x(i)-0.05,y(i)+0.03,['(' labels{perms(i,1)} ',' labels{perms(i,2)} ')'],'interpreter','latex')
    end
end
line([-1 1],[-1 1],'linestyle','--','color','r')
axis([-1 1 -1 1])
axis square
xlabel('\boldmath$\rho$ \textbf{(within)}','Interpreter','latex','fontsize',18)
ylabel('\boldmath$\rho$ \textbf{(between)}','Interpreter','latex','fontsize',18)
set(gca,'fontsize',14,'FontWeight','bold')