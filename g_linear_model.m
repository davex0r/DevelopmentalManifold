out_table = table;
for i = 1:3
    for j = 1:4
        indx = strcmpi(cel_data_table.bacteria,foods{j})&contains(cel_data_table.strain,names{i});
        if ~isempty(indx)
            tmp1 = table;
            tmp = cel_data_table(indx,:);
            tmp1.tDev = hours(tmp.t_dev-tmp.t_hatched);
            tmp1.Strain(:) = names(i);
            tmp1.Bacteria(:) = foods(j);
            out_table = [out_table; tmp1];
        end
    end
end
tmp2 = categorical(out_table.Strain)
tmp2 = reordercats(tmp2,{'N2','AB1','PS2025'});
out_table.Strain = tmp2
tmp3 = categorical(out_table.Bacteria)
tmp3 = reordercats(tmp3,{'HB101','DA1877','PFragi','BPumilus'});
out_table.Bacteria = tmp3
%%
clc
temp_strain = dummyvar(categorical(out_table.Strain));
N2 = temp_strain(:,1);
AB1 = temp_strain(:,2);
PS2025 = temp_strain(:,3);


temp_food = dummyvar(categorical(out_table.Bacteria));
HB101 = temp_food(:,1);
DA1877 = temp_food(:,2);
PFragi = temp_food(:,3);
BPumilus = temp_food(:,4);

tbl = table(PFragi,DA1877,BPumilus,HB101,N2,AB1,PS2025,out_table.tDev);

mdl = stepwiselm(tbl,'interactions','Intercept',false)
lm = fitlm(out_table,'interactions')

%%
plotInteraction(lm,'Strain','Bacteria','predictions')


%%
clear tmp*
p = 1;
dim = 6;
for i = 1:length(names)
    for j = [4 2 1 3]
%         indx = strcmpi(cel_data_table.bacteria,foods{j})&contains(cel_data_table.strain,names{i});
%         tmp{p} = hours(cel_data_table.t_dev(indx)-cel_data_table.t_hatched(indx));
        tmp_indx = cum_to_lin(cum_indx_linear(indx,:),i,j)
        tmp{p} = combined_data(tmp_indx,dim);
        xlabels{p} = [names{i} foods{j}];
        p=p+1;
    end
end
figure
for i = 1:3
    subplot(3,1,i)
    notBoxPlot(nCell2mat(tmp((i-1)*4+1:i*4)))
    set(gca,'xticklabel',xlabels((i-1)*4+1:i*4))
end
clear i j p tmp* xlabels dim