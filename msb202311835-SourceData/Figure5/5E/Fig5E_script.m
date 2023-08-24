% labels = {'phi1','tdev','phi3'};
% out_table = table;
% for i = 1:3
%     if i~=2
%     out_table.(labels{i})=c_3d(i,:)';
%     else
%         out_table.(labels{i}) = t_dev(indx);
%     end
% end
% writetable(out_table,'Fig5E.csv')
% %
% names = {'AB1','N2','PS2025','sid-2','C28'};
% foods = {'HB101','DA1877','Bpulimus','Pfragi'};
% out_table = table;
% for i =1:5
%     for j = 1:4
%         if ~isnan(out(i,j,1))
%         out_table.(names{i}+"_"+foods{j}) = squeeze(out(i,j,:))
%         end
%     end
% end
% writetable(out_table,'Fig5E_means.csv')
% %
labels = {'phi1','phi3','tdev'};
data = readtable("Fig5E.csv");
scatter(data.(labels{1}),data.(labels{2}),10,data.(labels{3}))
set(gca,'xlim',[-0.5 0.5],'ylim',[-0.2 0.3])
mean_data = readtable("Fig5E_means.csv");
names = {'AB1','N2','PS2025','sid_2','C28'};
foods = {'HB101','DA1877','Bpulimus','Pfragi'};
symbols = 's>do<^';
new_co = [ 0    0.4470    0.7410
0.8500    0.3250    0.0980
0.9290    0.6940    0.1250
0.4940    0.1840    0.5560
0.4660    0.6740    0.1880
0.3010    0.7450    0.9330
0.6350    0.0780    0.1840];
old_co = [0 0 1;
0 0.5 0;
1 0 0;
0 0.75 0.75;
0.75 0 0.75;
0.75 0.75 0;
0.25 0.25 0.25];
    hold on
for i = 1:5
    for j = 1:4
        if i<4
            plot(mean_data.(names{i}+"_"+foods{j})(1),mean_data.(names{i}+"_"+foods{j})(2),symbols(i),'Color','k','MarkerSize',12,'MarkerFaceColor',new_co(j,:))
        elseif j==1
            plot(mean_data.(names{i}+"_"+foods{j})(1),mean_data.(names{i}+"_"+foods{j})(2),symbols(i),'Color','k','MarkerSize',12,'MarkerFaceColor',old_co(i,:))
        end
    end
end
