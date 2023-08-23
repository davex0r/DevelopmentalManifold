% % This part generates the data for this figure from the combined dataset
% % It only needs to be run once.
%
% load('../../working_data_withPCA_230116.mat')
% i_s = [1 2 3];  j_s= [1 2 3]; m_s = [2 4 19];
% 
% for i = 1
% ind = find(cum_indx_linear(:,1)==i_s(i)&cum_indx_linear(:,2)==j_s(i)&cum_indx_linear(:,3)==m_s(i));
% [t_elapsed, wormlength, t_laid, l_laid, t_dev] = get_devDuration(cel_data,ind);
% end
% out_data = table();
% out_data.t_elapsed = t_elapsed;
% out_data.wormlength = wormlength;
% writetable(out_data,'Fig1D.csv')
%
data = readtable('Fig1D.csv');
plot(data.t_elapsed,data.wormlength,'.')
