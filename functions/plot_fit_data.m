function plot_fit_data(varargin)

p = inputParser;
p.addRequired('data',@(x) isstruct(x));
p.addRequired('index',@isnumeric);
p.addRequired('fit',@isnumeric);
p.addParameter('type','raw',@(x) ischar(x) && (strcmp(x,'raw') || strcmp(x,'norm')));

p.parse(varargin{:})
inputs = p.Results;
cel_data = inputs.data;
i = inputs.index;
fit_data = inputs.fit;


[t_elapsed, wormlength, ~, l_laid, t_dev] = get_devDuration(cel_data,i);
if strcmp(inputs.type,'raw')
    t_sim = linspace(0,4000,100);
    plot(t_elapsed,wormlength,'.')
    hold on
    plot(t_sim,logistic(fit_data(i,:),t_sim))
else
    t_sim = linspace(0,1.5,100);
    plot(t_elapsed/t_dev,wormlength/l_laid,'.')
    hold on
    plot(t_sim,logistic(fit_data(i,:),t_sim))
end
