%% Fraction on Food, All Individuals
clear
clc
load celData_673.mat
[~,new_co] = init_color;
for i = 1:length(names)
    for j = 1:length(foods)
        indx = cum_indx_linear(:,1)==i&cum_indx_linear(:,2)==j;
        if ~isempty(indx)
           
            tmp = cel_data_table(indx,:);
            tmp2 = [];
            for k = 1:height(tmp)
                tmp1 = tmp.time_series{k}.Centroid;
                tmp2 = [tmp2; tmp1];
                out{i,j} = tmp2;
            end
        end
    end
end
clear i j k indx tmp*
%% Developmental durations
clear tmp*
p = 1;
for i = 1:length(names)
    for j = 1:length(foods)
        indx = strcmpi(cel_data_table.bacteria,foods{j})&contains(cel_data_table.strain,names{i});
        tmp{p} = hours(cel_data_table.t_dev(indx)-cel_data_table.t_hatched(indx));
        xlabels{p} = [names{i} foods{j}];
        p=p+1;
    end
end
figure
for i = 1:3
    subplot(3,1,i)
    notBoxPlot(nCell2mat(tmp((i-1)*4+1:i*4)))
    set(gca,'xticklabel',xlabels((i-1)*4+1:i*4),'ylim',[35 80])
end
clear i j
%% Correlation all Individals (dev duration vs. fonf)
out_data = {};
edges = sqrt(0:100000:1000000);
for i = 1:length(names)
    for j = 1:length(foods)
        indx = cum_indx_linear(:,1)==i&cum_indx_linear(:,2)==j;
        if ~isempty(indx)
            tmp = cel_data_table(indx,:);
            h = nan(length(edges)-1,height(tmp));
            dev_time = nan(1,height(tmp));
            for k = 1:height(tmp)
                tmp1 = tmp.time_series{k}.Centroid;
                tmp1 = tmp1-[778 1025];
                r = sqrt(sum(tmp1.^2,2));
                h(:,k) = histcounts(r,edges,'Normalization','probability');
                dev_time(k) = hours(tmp.t_dev(k)-tmp.t_hatched(k));
            end
            out_data{i,j} = cumsum(h);
            out_tdev{i,j} = dev_time;
        end
    end
end
plot(edge2cntr(edges),out_data{1,2})
frac_on_food = cellfun(@(x) x(3,:),out_data,'UniformOutput',0);
for i = 1:5
    for j = 1:4
        if ~isempty(out_data{i,j})
            plot(out_tdev{i,j},frac_on_food{i,j},'+','color',new_co(j,:))
            hold on
        end
    end
end

y = [frac_on_food{:}];
x = [out_tdev{:}];

stats = regstats(y,x,'linear','beta');
[top_int, bot_int, X, Y] = regression_line_ci(.05,stats.beta,x,y,100,30,80);
[r,p] = corrcoef(x,y);
plot(X,Y,'red','LineWidth',2);
plot(X,top_int,'green--','LineWidth',2);
plot(X,bot_int,'green--','LineWidth',2);
set(gca,'fontsize',14,'FontWeight','bold')
ylabel('Fraction \it{on food}')
xlabel('Developmental Duration (h)')
%% Centroid Density Heatmaps
figure
for i = 1:5
    for j = 1:4
        if ~isempty(out{i,j})
            subplot(5,4,(i-1)*4+j)
            h = histcounts2(out{i,j}(:,1),out{i,j}(:,2),0:100:1600,0:100:2100,'Normalization','probability');
            imagesc((0:100:2100)*2.67/1000,(0:100:1600)*2.67/1000,h,[0 2e-2])
            set(gca,'xaxislocation','top')
            set(gca,'fontsize',14,'FontWeight','bold')
            hold on
            circle([1025 778]*2.67/1000,1.3,50,{'r'});
            axis equal
            axis tight
        end
        if j==1
            ylabel(names(i))
        end
        if i==1
            xlabel(foods{j})
        end
    end
end
subplot(5,4,[14 15])
set(gca,'clim',[0 0.02])
axis off
colorbar('Fontsize',14','fontweight','bold','location','North')
%% Radial distribtion functions
figure
p = 1;
clear hh
for i = 1:5
    for j = 1:4
        
        if ~isempty(out{i,j})
            subplot(5,4,(i-1)*4+j)
            tmp = out{i,j};
            tmp = tmp - [778 1025];
            r = sqrt(sum(tmp.^2,2));
            histogram(r,sqrt(0:100000:1000000),'Normalization','pdf')
            hh(i,j,:) = histcounts(r,sqrt(0:100000:1000000),'Normalization','probability');
            p = p+1;
            set(gca,'ylim',[0 3e-3])
            set(gca,'fontsize',14,'FontWeight','bold')
        end
        if j==1
            ylabel(names(i))      
        end
        if i==1
            title(foods{j})
%             set(gca,'xaxislocation','top')
        end
    end
end
%% Cumulative RDF
clc
[~, new_co] = init_color;
figure
symbols = {'+-','>-','s-','<-','o-'};
edges = sqrt(0:100000:1000000);
for i = 1:5
    for j = 1:4
        if ~isempty(out{i,j})
            plot([0 edge2cntr(edges)]*2.67/1000,[0 cumsum(squeeze(hh(i,j,:))')],symbols{i},'color',new_co(j,:),'linewidth',2)
            set(gca,'fontsize',14,'FontWeight','bold')
            hold on
        end
    end
end
xlabel('Radial Distance (mm)')
indx1 = cellfun(@isempty,out);
indx2 = indx1';

legend(xlabels(~indx2(:)))
hold on
line([1.3 1.3],[0 1],'HandleVisibility','off')
%% Dev duration distributions
figure
mean_dev_time = nan(5,4);
for i = 1:length(names)
    for j = 1:length(foods)
        indx = strcmpi(cel_data_table.bacteria,foods{j})&contains(cel_data_table.strain,names{i});
        tmp = hours(cel_data_table.t_dev(indx)-cel_data_table.t_hatched(indx));
        if ~isempty(out{i,j})
        subplot(5,4,(i-1)*4+j)
        histogram(tmp,33:3:69,'Normalization','pdf')
        set(gca,'fontsize',14,'FontWeight','bold')
        xlabel('Dev. Duration (h)')
        set(gca,'ylim',[0 0.2])
        mean_dev_time(i,j) = median(tmp,'omitnan');
        if j==1
            ylabel(names(i))
        end
        if i==1
            title(foods{j})
%             set(gca,'xaxislocation','top')
        end
        end
    end
end
%% Correlation of mean developmetnal duration and mean fonf
figure
frac_on_food = sum(hh(:,:,1:2),3);
plot(mean_dev_time(:),frac_on_food(:),'+','MarkerSize',8,'linewidth',2)
hold on
y = frac_on_food(:);
x = mean_dev_time(:);
x = x(~indx1(:));
y = y(~indx1(:));
stats = regstats(y,x,'linear','beta');
[top_int, bot_int, X, Y] = regression_line_ci(.05,stats.beta,x,y,100,35,65);
[r,p] = corrcoef(x,y);
plot(X,Y,'red','LineWidth',2);
plot(X,top_int,'green--','LineWidth',2);
plot(X,bot_int,'green--','LineWidth',2);
set(gca,'fontsize',14,'FontWeight','bold')
ylabel('Fraction On Food')
xlabel('Mean Developmental Duration (h)')