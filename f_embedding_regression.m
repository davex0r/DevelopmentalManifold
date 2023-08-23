clear
load working_data_withPCA_230116.mat
linear_model_table = table;
combined_data = center_scale([fits_raw(indx,:) t_laid(indx) t_utero(indx) l_laid(indx) l_hatch(indx)]);
tmp_t_dev = t_dev(indx);
tmp_l_dev = l_laid(indx);
tmp_fits_norm = fits_norm(indx,:);
tmp_fits_raw = fits_raw(indx,:);
clear mdl
[coeff, score]  = pca(combined_data);
tmp_score = score;
for i = 1:3
    for j = 1:4
        tmp_table = table;
        tmp_indx = cum_to_lin(cum_indx_linear(indx,:),i,j);
        sum(tmp_indx)
        tmp_table.tDev = tmp_t_dev(tmp_indx);
        tmp_table.lDev = tmp_l_dev(tmp_indx);
        tmp_table.phi1 = c_3d(1,tmp_indx)';
        tmp_table.phi2 = c_3d(2,tmp_indx)';
        tmp_table.Strain(:) = names(i);
        tmp_table.Bacteria(:) = foods(j);
        tmp_table.lhat = tmp_fits_norm(tmp_indx,1);
        tmp_table.rhat = tmp_fits_norm(tmp_indx,2);
        tmp_table.Ahat = tmp_fits_norm(tmp_indx,3);
%         tmp_table.gamma1 = tmp_score(tmp_indx,1);
%         tmp_table.gamma2 = tmp_score(tmp_indx,2);
        linear_model_table = [linear_model_table; tmp_table];
    end
end
% mdl = fitlm(linear_model_table,'phi1~Strain+Bacteria')
out_F = [];
out_P = [];
tmp_preds = {'phi1','phi2','lhat','rhat','Ahat','tDev','lDev'} %,'gamma1','gamma2'};
for i = 1:length(tmp_preds)
mdl{i} = fitlm(linear_model_table,'ResponseVar',tmp_preds{i},'PredictorVars',{'Strain','Bacteria'});
tmp = mdl{i}.anova;
out_F(:,i) = tmp.F(1:2);
out_P(:,i)  = tmp.pValue(1:2);
end
bar((out_F)')
tmp_labels = {'\boldmath$\phi_1$','\boldmath$\phi_2$','\boldmath$\hat{l}$',...
    '\boldmath$\hat{r}$','\boldmath$\hat{A}$'...
    ,'\boldmath$t_{dev}$','\boldmath$l_{dev}$','\boldmath$\gamma_1$','\boldmath$\gamma_2$'};
set(gca,'XTickLabel',tmp_labels(1:length(tmp_preds)),'TickLabelInterpreter','latex','fontsize',18,'fontweight','bold')
ylabel('$F$-statistic','Interpreter','latex')
legend({'Strain','Bacteria'})
clear tmp* i j
%%
clc
categories(categorical(linear_model_table.Strain))
temp_strain = dummyvar(categorical(linear_model_table.Strain));
AB1 = temp_strain(:,1);
N2 = temp_strain(:,2);
PS2025 = temp_strain(:,3);

categories(categorical(linear_model_table.Bacteria))
temp_food = dummyvar(categorical(linear_model_table.Bacteria));
BPumilus = temp_food(:,1);
DA1877 = temp_food(:,2);
HB101 = temp_food(:,3);
PFragi = temp_food(:,4);

tbl = table(PFragi,DA1877,BPumilus,HB101,N2,AB1,PS2025,linear_model_table.tDev);

mdl = stepwiselm(tbl,'interactions','Intercept',false)
clear N2 AB1 PS2025 HB101 DA1877 PFragi BPumilus temp*

