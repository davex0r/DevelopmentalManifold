function Z = zscore_nan(X)

Z = (X-mean(X,'omitnan'))/std(X,'omitnan');