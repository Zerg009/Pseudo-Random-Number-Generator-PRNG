clear
clc
close all

for i = 1 : 10000
    x(i) = normrnd(3,0.1);
end




h = histogram(x);
h.BinMethod = 'auto';
% h.BinWidth = 0.05;
