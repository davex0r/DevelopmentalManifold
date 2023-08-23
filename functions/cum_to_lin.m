function linear_indx = cum_to_lin(cum_indx,i,j)

if isempty(i)
    linear_indx = cum_indx(:,2)==j;
elseif isempty(j)
    linear_indx = cum_indx(:,1)==i;
else
    linear_indx = cum_indx(:,1)==i&cum_indx(:,2)==j;
end