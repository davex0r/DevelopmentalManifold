function [t_elapsed, wormlength, t_laid, l_laid, t_dev] = get_devDuration(varargin)

p = inputParser;
p.addRequired('data',@(x) isstruct(x));
p.addRequired('index',@isnumeric);
p.addParameter('l_est','fit',@(x) ischar(x) && (strcmp(x,'direct') || strcmp(x,'fit')));

p.parse(varargin{:})
inputs = p.Results;
cel_data = inputs.data;
i = inputs.index;

t_elapsed = minutes(duration(datetime(cel_data(i).time_series.time,'TimeZone','Europe/London')-cel_data(i).t_hatched));
t_dev = minutes(duration(cel_data(i).t_dev-cel_data(i).t_hatched));
wormlength = cel_data(i).time_series.wormlength*cel_data(i).scale;

if ~isnan(t_dev)
    [~, indx] = min(abs(t_dev-t_elapsed));
    if strcmp(inputs.l_est,'direct')
        l_laid = wormlength(indx);
    else
        options = optimset('Algorithm','trust-region-reflective','Display','off');
        l_lb = [];
        l_ub = [3000 inf 5000];
        l_x0 = [max(wormlength)*1.2,0.001,t_elapsed(ceil(length(t_elapsed)/2))];
        [cfit,~,~,~] = lsqcurvefit(@logistic,l_x0,t_elapsed,wormlength,l_lb,l_ub,options);
        l_laid = logistic(cfit,t_dev);
    end

    t_laid = t_elapsed(indx);
else
    t_laid = t_elapsed(end);
    l_laid = wormlength(end);
end


