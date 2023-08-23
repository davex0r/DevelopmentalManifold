% % This part generates the data for this figure from the combined dataset
% % It only needs to be run once.
%
% load('../../working_data_withPCA_230116.mat')
% i_s = [1 2 3];  j_s= [1 2 3]; m_s = [2 4 19];
% 
% out_data = table();
% for i = 1:3
% ind = find(cum_indx_linear(:,1)==i_s(i)&cum_indx_linear(:,2)==j_s(i)&cum_indx_linear(:,3)==m_s(i));
% [t_elapsed, wormlength, t_laid, l_laid, t_dev] = get_devDuration(cel_data,ind);
% t{i} = t_elapsed;
% l{i} = wormlength;
% 
% end
% out = nCell2mat([t l]);
% for i = 1:3
%     name0 = "example"+i;
%     out_data.(name0+"t_elapsed") = out(:,i);
%     out_data.(name0+"wormlength") = out(:,3+i);
% end
% 
% writetable(out_data,'Fig1E.csv')

data = readtable('Fig1E.csv');
for i = 1:3
plot(data.("example"+i+"t_elapsed"),data.("example"+i+"wormlength"),'.')
hold on
end