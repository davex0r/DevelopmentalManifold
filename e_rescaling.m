set(0,'DefaultFigureWindowStyle','normal')
xspan = 5; yspan = 13;
nperSpan = 60;
figure(1)
clf
set(gcf,'pos',[600 50 nperSpan*[xspan yspan]]);
locs = [];
locs(1,:) = [1.3 9 3 3];
locs(2,:) = [1.3 5 3 3];
locs(3,:) = [1.3 1 3 3];

locs = bsxfun(@rdivide,locs,[xspan yspan xspan yspan]);
ax = gobjects(size(locs,1),1);
for i = 1:size(locs,1)
    ax(i) = axes;
    ax(i).Position = locs(i,:);
end

plot_normalization(cel_data,ax([1 2]))
plot_normalization_summary(cel_data,t_laid,l_laid,ax(3))
linkaxes(ax([2 3]),'x')
for i = 1:length(ax)
    set(ax(i),'fontsize',14,'fontweight','bold','box','on')
    if i>1
        set(ax(i),'xtick',[0:0.3:1.2],'ytick',[0:0.3:1.2],'xlim',[0.01 1.3])
    end
end
set(ax(1),'xtick',[0 2000 4000],'xlim',[0 4000],'ylim',[0.1 1.2])
clear xspan yspan nperSpan locs i ans