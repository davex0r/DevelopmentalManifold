function [r_sq_sample, r_sq_pop] = plot_correlations(varargin)



p = inputParser;
p.addRequired('data',@isnumeric);
p.addRequired('names',@(x) iscell(x));
p.addRequired('foods',@(x) iscell(x));
p.addRequired('cum_indx',@isnumeric);
p.addRequired('indx',@islogical);

p.addParameter('pub','off',@(x) (strcmp(x,'on') || strcmp(x,'off')));
p.addParameter('perms','all',@(x) (strcmp(x,'all') || (isnumeric(x))));
p.addParameter('ax','none',@(x) (strcmp(x,'none') || isa(x,'matlab.graphics.axis.Axes')));


p.parse(varargin{:})
inputs = p.Results;
combined_data = inputs.data;
foods = inputs.foods;
names = inputs.names;
cum_indx_linear = inputs.cum_indx;
indx = inputs.indx;

if strcmp(inputs.perms,'all')
    perms = nchoosek(1:size(combined_data,2),2);
else
    perms = inputs.perms;
end

if strcmp(inputs.ax,'none')&&strcmp(inputs.pub,'on')
    f = figure;
    ax(1) = subplot(1,2,1);
    ax(2) = subplot(1,2,2);
else
    ax = inputs.ax;
end
conditions = length(names)*length(foods);
[~, new_co] = init_color;
labels = {'\boldmath$\hat{l} \hspace{3mm} [1]$', '\boldmath$\hat{r}  \hspace{3mm} [1]$',...
    '\boldmath$\hat{A} \hspace{3mm} [1]$', '\boldmath$\tilde{t}_{dev}$ [1]', '\boldmath$\tilde{t}_{hatch}$ [1]' ,'\boldmath$\tilde{l}_{hatch}$ [1]','\boldmath$\tilde{l}_{laid}$ [1]'};
symbols = 's>do<^';


if strcmp(inputs.pub,'off')

    r_sq_sample = nan(conditions,size(perms,1));
    p_val_sample = r_sq_sample;
    for k = 1:size(perms,1)
        figure(k)
        sample_means = nan(conditions,size(combined_data,2));
        sample_stds = nan(conditions,size(combined_data,2));
        color_indx = nan(conditions,2);
        n_perms = perms(k,:);
        for i = 1:length(names)
            for j = 1:length(foods)
                tmp_indx = cum_to_lin(cum_indx_linear(indx,:),i,j);
                if sum(tmp_indx)>0
                    [tmp_data, sample_mean, sample_std, stats] = center_to_sample(combined_data,tmp_indx,i,j,n_perms);
                    sample_means((i-1)*length(foods)+j,:) = sample_mean;
                    sample_stds((i-1)*length(foods)+j,:) = sample_std;
                    subplot(5,4,(i-1)*length(foods)+j)
                    scatter(tmp_data(:,n_perms(1)),tmp_data(:,n_perms(2)),'MarkerFaceColor',new_co(j,:),'MarkerEdgeColor','k')
                    plot_regression(tmp_data(:,n_perms),stats,'range',[-4 4])
                    axis([-4 4 -4 4])
                    [tmp_r_sample, tmp_p_sample] = corrcoef(tmp_data(:,n_perms(1)),tmp_data(:,n_perms(2)));
                    r_sq_sample((i-1)*length(foods)+j,k) = tmp_r_sample(1,2);
                    p_val_sample((i-1)*length(foods)+j,k) = tmp_p_sample(1,2);
                    color_indx((i-1)*length(foods)+j,:) = [i, j];
                    xlabel(labels(n_perms(1)),'Interpreter','latex','fontsize',18)
                    ylabel(labels(n_perms(2)),'Interpreter','latex','fontsize',18)
                end
                
            end
        end
        subplot(5,4,[15:16 19:20])
        stats = regstats(sample_means(:,n_perms(1)),sample_means(:,n_perms(2)),'linear','beta');
        sm_indx = ~any(isnan(sample_means),2);
        sample_means = sample_means(sm_indx,:);
        sample_stds = sample_stds(sm_indx,:);
        color_indx = color_indx(sm_indx,:);
        for m = 1:size(sample_means,1)
            errorbar(sample_means(m,n_perms(1)),sample_means(m,n_perms(2)),sample_stds(m,n_perms(2))/sqrt(10),sample_stds(m,n_perms(2))/sqrt(10),...
                sample_stds(m,n_perms(1))/sqrt(10), sample_stds(m,n_perms(1))/sqrt(10),symbols(color_indx(m,1)),'LineWidth',2,'Color',new_co(color_indx(m,2),:))
            hold on
        end
        plot_regression(sample_means(:,n_perms),stats,'range',[-4 4])
        xlabel(labels(n_perms(1)),'Interpreter','latex','fontsize',18)
        ylabel(labels(n_perms(2)),'Interpreter','latex','fontsize',18)
        tmp_r = corrcoef(sample_means(:,n_perms(1)),sample_means(:,n_perms(2)));
        r_sq_pop(k) = tmp_r(1,2);
        axis([-4 4 -4 4])
    end
else
    
    r_sq_sample = nan(conditions,10);
    p_val_sample = r_sq_sample;
    for k = 1:size(perms,1)
        sample_means = nan(conditions,size(combined_data,2));
        sample_stds = nan(conditions,size(combined_data,2));
        color_indx = nan(conditions,2);
        n_perms = perms(k,:);
        figure(k)
        axes(ax(1))
        for i = 1:length(names)
            for j = 1:length(foods)
                tmp_indx = cum_to_lin(cum_indx_linear(indx,:),i,j);
                if sum(tmp_indx)>0
                    [tmp_data, sample_mean, sample_std, stats] = center_to_sample(combined_data,tmp_indx,i,j,n_perms);
                    sample_means((i-1)*length(foods)+j,:) = sample_mean;
                    sample_stds((i-1)*length(foods)+j,:) = sample_std;
                    scatter(tmp_data(:,n_perms(1)),tmp_data(:,n_perms(2)),5,'MarkerFaceColor',new_co(j,:),'MarkerEdgeColor',new_co(j,:))
                    plot_regression(tmp_data(:,n_perms),stats,'range',[-4 4],'color',new_co(j,:),'width',1,'CI','off')
                    axis([-4 4 -4 4])
                    [tmp_r_sample, tmp_p_sample] = corrcoef(tmp_data(:,n_perms(1)),tmp_data(:,n_perms(2)));
                    r_sq_sample((i-1)*length(foods)+j,k) = tmp_r_sample(1,2);
                    p_val_sample((i-1)*length(foods)+j,k) = tmp_p_sample(1,2);
                    color_indx((i-1)*length(foods)+j,:) = [i, j];
                    xlabel(labels(n_perms(1)),'Interpreter','latex')
                    ylabel(labels(n_perms(2)),'Interpreter','latex')
%                     out{i,j,1} = tmp_data(:,n_perms(1));
%                     out{i,j,2} = tmp_data(:,n_perms(2));
                end
            end
        end
%         out{1} = sample_means;
%         out{2} = sample_stds;
        %         stats = regstats(combined_data(:,n_perms(1)),combined_data(:,n_perms(2)),'linear','beta');
%         plot_regression(combined_data(:,n_perms),stats,'range',[-4 4])
        axis square
        axes(ax(2))
        stats = regstats(sample_means(:,n_perms(1)),sample_means(:,n_perms(2)),'linear','beta');
        sm_indx = ~any(isnan(sample_means),2);
        sample_means = sample_means(sm_indx,:);
        sample_stds = sample_stds(sm_indx,:);
        color_indx = color_indx(sm_indx,:);
        for m = 1:size(sample_means,1)
            errorbar(sample_means(m,n_perms(1)),sample_means(m,n_perms(2)),sample_stds(m,n_perms(2)),sample_stds(m,n_perms(2)),...
                sample_stds(m,n_perms(1)), sample_stds(m,n_perms(1)),symbols(color_indx(m,1)),'LineWidth',1.5,'Color',new_co(color_indx(m,2),:))
            hold on
        end
        plot_regression(sample_means(:,n_perms),stats,'range',[-4 4])
        xlabel(labels(n_perms(1)),'Interpreter','latex')
        ylabel(labels(n_perms(2)),'Interpreter','latex')
        tmp_r = corrcoef(sample_means(:,n_perms(1)),sample_means(:,n_perms(2)));
        r_sq_pop(k) = tmp_r(1,2);
        axis([-4 4 -4 4])
        axis square
    end
    
end