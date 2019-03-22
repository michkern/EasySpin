function [err,data] = test(opt,olddata)

%====================================================
% non negative check
%====================================================
y = ones(1,100);
y(1) = -1;
y(2) = 2;
z = -2*y;

[y_,lsq] = rescale(y,z,'lsq');
[y_,lsq0] = rescale(y,z,'lsq0');
[y_,lsq1] = rescale(y,z,'lsq1');
[y_,lsq2] = rescale(y,z,'lsq2');
scale = [lsq(1) lsq0(1) lsq1(1) lsq2(1)];
err = any(scale<0);
data =[];
