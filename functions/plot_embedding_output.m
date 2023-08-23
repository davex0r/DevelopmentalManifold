function [tmp, tmp1] = plot_embedding_output(c,dims,names,foods,cum_indx_linear,t_max,symbols)
clc
if isempty(symbols)
    symbols = 's>do<^';
end
scatter3(c(dims(1),:),c(dims(2),:),c(dims(3),:),10,t_max,'MarkerFaceColor','flat')
hold on
[~,new_co] = init_color;
p=1;
for i = 1:length(names)
    for j = 1:length(foods)
        indx = cum_to_lin(cum_indx_linear,i,j);
        if ~isempty(indx)
            plot3(mean(c(dims(1),indx)),mean(c(dims(2),indx)),mean(c(dims(3),indx)),symbols(i),'Color','k','MarkerSize',12,'MarkerFaceColor',new_co(j,:))
            [names{i} foods{j} num2str(median(c(dims(2),indx)))]
            if ~isnan(mean(c(dims(2),indx)))
            tmp(p) = mean(c(dims(2),indx))
            tmp1{p} = [names{i} foods{j}]
            p = p+1;
            end
        end
    end
end
