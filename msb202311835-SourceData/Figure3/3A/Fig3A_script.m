% a = out(:,:,1);
% a1 = nCell2mat(a(:)');
% b = out(:,:,2);
% b1 = nCell2mat(b(:)');
% for i = 1:size(a1,2)
%     plot(a1(:,i),b1(:,i),'.')
%     hold on
% end
% 
% for i = 1:length(names)
%     for j = 1:length(foods)
%         tmp_indx = cum_to_lin(cum_indx_linear(indx,:),i,j);
%         if sum(tmp_indx)>0
%             names0{i,j} = [names{i} '_' foods{j}]
%         end
%     end
% end
% 
% out_data = table;
% name0 = names0(:);
% for i = 1:size(a1,2)
%     if ~isempty(name0{i})
%     out_data.(name0{i}+"_lhat") = a1(:,i);
%     out_data.(name0{i}+"_rhat") = b1(:,i);
%     end
% end
% % 
clear

new_co = [ 0    0.4470    0.7410
0.8500    0.3250    0.0980
0.9290    0.6940    0.1250
0.4940    0.1840    0.5560
0.4660    0.6740    0.1880
0.3010    0.7450    0.9330
0.6350    0.0780    0.1840];

data = readtable('Fig3A.csv');
names = {'AB1','N2','PS2025','Sid','C28'};
foods = {'HB101','DA1877','BPumilus','PFragi'};
for i = 1:length(names)
    for j = 1:length(foods)
        if ~(i>3&&j>1)
        names0 = [names{i} '_' foods{j}];
        stats = regstats(data.(names0+"_lhat"),data.(names0+"_rhat"),'linear','beta');
        plot(data.(names0+"_lhat"),data.(names0+"_rhat"),'.')
        hold on
        [top_int, bot_int, X, Y] = regression_line_ci(.05,stats.beta,data.(names0+"_lhat"),data.(names0+"_rhat"),100,-4,4);
        plot(X,Y,'color',new_co(j,:),'linewidth',2);
        end
    end
end
set(gca,'xlim',[-4 4],'ylim',[-4 4])
axis square
xlabel('\boldmath$z_{sample}(\hat{l}) \hspace{3mm} [1]$','Interpreter','latex')
ylabel( '\boldmath$z_{sample}(\hat{r})  \hspace{3mm} [1]$','Interpreter','latex')