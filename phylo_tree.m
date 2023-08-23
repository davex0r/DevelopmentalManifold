clear
clc
Tree = phytreeread('./WI.20220216.hard-filter.isotype.min4.tree')
indx_n2 = (contains(get(Tree,'LeafNames'),{'N2'}));
indx_wn2 = (contains(get(Tree,'LeafNames'),{'WN2'}));
indx = contains(get(Tree,'LeafNames'),{'AB1','PS2025','CB4856','MY10','DL238'})
indx1 = ((indx_n2&~indx_wn2)|indx)
tr = prune(Tree,~indx1)
view(tr)
%%
set(gcf,'Position',[100 100 400 400])
ax = gca;
set(ax.Children(1:6),'FontSize',14)
set(ax,'FontSize',16)
set(ax.Children(18:end),'linewidth',2,'Markersize',10)
xlabel('Distance')
set(ax.Children([1 5 6]),'color','r')
set(ax,'Position',[0.0518 0.1229 0.8 0.8133])