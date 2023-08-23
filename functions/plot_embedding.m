function plot_embedding(c,dims,names,foods,cum_indx_linear,t_max,symbols)
clc
if isempty(symbols)
    symbols = 's>do<^';
end
scatter(c(dims(1),:),c(dims(2),:),10,t_max,'MarkerFaceColor','flat')
hold on
[~,new_co] = init_color;
for i = 1:length(names)
    for j = 1:length(foods)
        indx = cum_to_lin(cum_indx_linear,i,j);
        if ~isempty(indx)
            plot(mean(c(dims(1),indx)),mean(c(dims(2),indx)),symbols(i),'Color','k','MarkerSize',12,'MarkerFaceColor',new_co(j,:))
%             out(i,j,1) = mean(c(dims(1),indx));
%             out(i,j,2) = mean(c(dims(2),indx));
        end
    end
end
% out
