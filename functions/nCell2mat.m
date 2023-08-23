function a = nCell2mat(tmp)

tmp1 = cellfun(@(x) length(x),tmp);
a = nan(max(tmp1),length(tmp));
for i = 1:length(tmp)
    a(1:length(tmp{i}),i)=tmp{i}';
end
% a = a';