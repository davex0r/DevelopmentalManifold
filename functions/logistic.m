function l = logistic(x,t)
l = (x(1)./(1+exp(-x(2).*(t-x(3)))));
end