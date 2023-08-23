function l = general_logistic(x,t)
l = x(1) + ((x(2)-x(1))./(1+exp(-x(3).*(t-x(4)))).^(1/x(5)));
end