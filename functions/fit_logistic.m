function [fits, residuals] = fit_logistic(varargin)

p = inputParser;
p.addRequired('data',@(x) isstruct(x));
p.addParameter('fit_type','raw',@(x) ischar(x) && (strcmp(x,'raw') || strcmp(x,'norm')));
p.addParameter('l_est','fit',@(x) ischar(x) && (strcmp(x,'fit') || strcmp(x,'direct')));

p.parse(varargin{:})
inputs = p.Results;

cel_data = inputs.data;
options = optimset('Algorithm','trust-region-reflective','Display','off');

if strcmp(inputs.fit_type,'raw')
    l_lb = [];
    l_ub = [3000 inf 5000];
    fits = nan(length(cel_data),3);
    residuals = nan(length(cel_data),1);
    for i = 1:length(cel_data)
        [t_elapsed, wormlength, ~, ~] = get_devDuration(cel_data,i);
        l_x0 = [max(wormlength)*1.2,0.001,t_elapsed(ceil(length(t_elapsed)/2))];
        [cfit,resnorm,~,~] = lsqcurvefit(@logistic,l_x0,t_elapsed,wormlength,l_lb,l_ub,options);
        fits(i,:) = cfit;
        residuals(i) = resnorm;
    end
else
    fits = nan(length(cel_data),3);
    residuals = nan(length(cel_data),1);
    t_laid = nan(length(cel_data),1);
    w_laid = t_laid;
    t_dev = t_laid;
    l_lb = [];
    l_ub = [3.9 inf 2];

    for i = 1:length(cel_data)
        [t_elapsed, wormlength, t_laid(i), w_laid(i), t_dev(i)] = get_devDuration(cel_data,i,'l_est',inputs.l_est);
        l_x0 = [max(wormlength)*1.2,0.001,t_elapsed(ceil(length(t_elapsed)/2))];
        l_x0 = l_x0.*[1/w_laid(i) t_laid(i) 1/t_laid(i)];

        t_elapsed = t_elapsed/t_laid(i);
        wormlength = wormlength/w_laid(i);

        [cfit,resnorm,~,~] = lsqcurvefit(@logistic,l_x0,t_elapsed,wormlength,l_lb,l_ub,options);
        fits(i,:) = cfit;
        residuals(i) = resnorm;
    end
end