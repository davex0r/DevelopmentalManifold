function [r,p] = plot_regression(varargin)

p = inputParser;
p.addRequired('data',@isnumeric);
p.addRequired('stats',@(x) isstruct(x));
p.addParameter('range','auto',@(x) (strcmp(x,'auto') || isnumeric(x)));
p.addParameter('color','r',@(x) ischar(x) || isnumeric(x));
p.addParameter('width',2,@(x) isnumeric(x));
p.addParameter('CI','on',@(x) (strcmp(x,'on') || strcmp(x,'off')));

p.parse(varargin{:})
inputs = p.Results;
data = inputs.data;
stats = inputs.stats;
color = inputs.color;
width = inputs.width;

if strcmp(inputs.range,'auto')
    range = [min(data(:,1)) max(data(:,1))];
else
    range = inputs.range;
end


hold on
[top_int, bot_int, X, Y] = regression_line_ci(.05,stats.beta,data(:,1),data(:,2),100,range(1),range(2));
plot(X,Y,'color',color,'LineWidth',width);
if strcmp(inputs.CI,'on')
plot(X,top_int,'green--','LineWidth',1);
plot(X,bot_int,'green--','LineWidth',1);
end
[r,p] = corrcoef(data(:,1),data(:,2));