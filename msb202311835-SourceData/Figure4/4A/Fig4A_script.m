% labels = {'lhat','rhat','Ahat'};
% out_table = table;
% for i = 1:3
%     out_table.(labels{i})=scaled_raw_data(:,i);
% end
% writetable(out_table,'Fig4A.csv')

labels = {'lhat','rhat','Ahat'};
data = readtable('Fig4A.csv');
plot3(data.(labels{1}),data.(labels{2}),data.(labels{3}),'.')
box on
view([130 20])