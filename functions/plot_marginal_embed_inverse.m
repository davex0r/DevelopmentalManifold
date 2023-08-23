function ax = plot_marginal_embed(c_3d, names,foods,cum_indx_linear,t_dev,indx,net)

set(0,'DefaultFigureWindowStyle','normal')
xspan = 15; yspan = 10;
nperSpan = 60;
figure(1)
clf
set(gcf,'pos',[100 50 nperSpan*[xspan yspan]]);
locs = [];
locs(1,:) = [5.5 1 9 4];
locs(2,:) = [5.5 6 9 3];
locs(3,:) = [1 1 3 4];
locs(4,:) = [1 6 3 3];

locs = bsxfun(@rdivide,locs,[xspan yspan xspan yspan]);
ax = gobjects(size(locs,1),1);
for i = 1:size(locs,1)
    ax(i) = axes;
    ax(i).Position = locs(i,:);
end


symbols = 's>do<^';
[~,new_co] = init_color;
axes(ax(1))
plot_embedding(c_3d,[1 2],names(1:3),foods,cum_indx_linear(indx,:),t_dev(indx),symbols)
xlabel('\boldmath$\phi_1$','Interpreter','latex','FontSize',18)
ylabel('\boldmath$\phi_2$','Interpreter','latex','FontSize',18)


box on
axes(ax(2))
dims =1;
for j = 1:3
    tmp_indx = cum_to_lin(cum_indx_linear,j,[]);
    if ~isempty(indx)
        [h, xi] = ksdensity(c_3d(dims,tmp_indx(indx)));
        plot(xi,h,[symbols(j) '-'],'linewidth',1,'color',[0.5 0.5 0.5])
        hold on
    end
end
ylabel('\boldmath$pdf(\phi_1)$','Interpreter','latex','FontSize',18)
xlabel('\boldmath$\phi_1$','Interpreter','latex','FontSize',18)
linkaxes(ax([1 2]),'x')
legend(names(1:3))

axes(ax(3))
dims = 2;
foods_toPlot = [1 2 3 4];
for i = foods_toPlot
    tmp_indx = cum_to_lin(cum_indx_linear,[],i);
    if ~isempty(indx)
        [h, xi] = ksdensity(c_3d(dims,tmp_indx(indx)),'numpoints',50);
        var(c_3d(dims,tmp_indx(indx)))
        plot(h,xi,'linewidth',2,'color',new_co(i,:))
        hold on
    end
end
xlabel('\boldmath$pdf(\phi_2)$','Interpreter','latex','FontSize',18)
ylabel('\boldmath$\phi_2$','Interpreter','latex','FontSize',18)
set(ax(3),'xdir','reverse')
legend(foods(foods_toPlot),'location','northwest')
linkaxes(ax([1 3]),'y')

axes(ax(4))
nlpca_plot(net)
axis on
box on
xlabel('$\boldmath\hat{l} \hspace{1mm} [1]$','Interpreter','latex','fontsize',18)
ylabel('$\boldmath\hat{r} \hspace{1mm} [1]$','Interpreter','latex','fontsize',18)
zlabel('$\boldmath\hat{A} \hspace{1mm} [1]$','Interpreter','latex','fontsize',18)
view([1 1 0.3])