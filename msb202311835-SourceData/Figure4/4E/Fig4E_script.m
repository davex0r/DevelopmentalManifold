% load working_data_withPCA_230116.mat
% linear_model_table = table;
% tmp_t_dev = t_dev(indx);
% tmp_l_dev = l_laid(indx);
% tmp_fits_norm = fits_norm(indx,:);
% tmp_fits_raw = fits_raw(indx,:);
% clear mdl
% [coeff, score]  = pca(combined_data);
% tmp_score = score;
% for i = 1:3
%     for j = 1:4
%         tmp_table = table;
%         tmp_indx = cum_to_lin(cum_indx_linear(indx,:),i,j);
%         sum(tmp_indx)
%         tmp_table.tDev = tmp_t_dev(tmp_indx);
%         tmp_table.lDev = tmp_l_dev(tmp_indx);
%         tmp_table.phi1 = c_3d(1,tmp_indx)';
%         tmp_table.phi2 = c_3d(2,tmp_indx)';
%         tmp_table.Strain(:) = names(i);
%         tmp_table.Bacteria(:) = foods(j);
%         tmp_table.lhat = tmp_fits_norm(tmp_indx,1);
%         tmp_table.rhat = tmp_fits_norm(tmp_indx,2);
%         tmp_table.Ahat = tmp_fits_norm(tmp_indx,3);
%         linear_model_table = [linear_model_table; tmp_table];
%     end
% end
% out_F = [];
% out_P = [];
% tmp_preds = {'phi1','phi2','lhat','rhat','Ahat','tDev','lDev'};
% for i = 1:length(tmp_preds)
%     mdl{i} = fitlm(linear_model_table,'ResponseVar',tmp_preds{i},'PredictorVars',{'Strain','Bacteria'});
%     tmp = mdl{i}.anova;
%     out_F(:,i) = tmp.F(1:2);
% 
% end
% 
% names = {'phi1','phi2','lhat','rhat','Ahat','tDev','lDev'};
% for i = 1:length(names)
%     tmp = anova(mdl{i});
%     name = ("Fig4E_anova_"+names{i}+".csv");
%     writetable(tmp(1:end,:),name,'WriteRowNames',1)
% end
% % 
names = {'phi1','phi2','lhat','rhat','Ahat','tDev','lDev'};
for i = 1:length(names)
    name = ("Fig4E_anova_"+names{i}+".csv");
    data = readtable(name);
    out(i,1:2)=data.F(1:2)
end
bar(out)
set(gca,'XTickLabel',names)
ylabel('F-statistic')
legend(data.Row(1:2))
