% labels = {'phi1','phi2','tdev'};
% out_table = table;
% for i = 1:3
%     if i<3
%     out_table.(labels{i})=c_3d(i,:)';
%     else
%         out_table.(labels{i}) = t_dev(indx);
%     end
% end
% writetable(out_table,'Fig4D.csv')
% %
% names = {'AB1','N2','PS2025'};
% foods = {'HB101','DA1877','Bpulimus','Pfragi'};
% out_table = table;
% for i =1:3
%     for j = 1:4
%         out_table.(names{i}+"_"+foods{j}) = squeeze(out(i,j,:))
%     end
% end
% writetable(out_table,'Fig4D_means.csv')
% %
labels = {'phi1','phi2','tdev'};
data = readtable("Fig4D.csv");
scatter(data.(labels{1}),data.(labels{2}),10,data.(labels{3}))
set(gca,'xlim',[-0.5 0.5],'ylim',[-0.2 0.3])
mean_data = readtable("Fig4D_means.csv");
names = {'AB1','N2','PS2025'};
foods = {'HB101','DA1877','Bpulimus','Pfragi'};
symbols = 's>do<^';
    new_co = [ 0    0.4470    0.7410
0.8500    0.3250    0.0980
0.9290    0.6940    0.1250
0.4940    0.1840    0.5560
0.4660    0.6740    0.1880
0.3010    0.7450    0.9330
0.6350    0.0780    0.1840];
    hold on
for i = 1:3
    for j = 1:4
        plot(mean_data.(names{i}+"_"+foods{j})(1),mean_data.(names{i}+"_"+foods{j})(2),symbols(i),'Color','k','MarkerSize',12,'MarkerFaceColor',new_co(j,:))
    end
end
