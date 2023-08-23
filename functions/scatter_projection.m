function scatter_projection(data,color,msize)

data = center_scale(data);

X = data(:,1); Y = data(:,2); Z = data(:,3);
plot3(X,Y,Z,'.','color',color,'Markersize',msize)
xlims = get(gca,'xlim');
ylims = get(gca,'ylim');
zlims = get(gca,'zlim');

box on
hold on
plot3(X,Y,Z,'o','color','r','MarkerSize',msize)
hold on
plot3(X, Y, zlims(1)*ones(size(Z)),'.','color',[0.8 0.8 0.8]);    %projection from Z+
plot3(X, ylims(1)*ones(size(Y)), Z,'.','color',[0.8 0.8 0.8]);    %projection from Y-
plot3(xlims(1)*ones(size(X)), Y, Z,'.','color',[0.8 0.8 0.8]);    %projection from X+
view([1 1 0.3])
