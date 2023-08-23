function t = inv_logistic(params,l)
l_max = params(1); r = params(2); A = params(3);

t = (log((l_max-l)/(l))/-r)+A;