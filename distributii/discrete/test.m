clc
clear
close all

x = [3 4 5 9]
p = [0.3 0.1 0.1 0.5]

k3 = 0;
k4 = 0;
k5 = 0;
k9 = 0;

for i = 1 : 100
    z(i) = SimDiscretN(x, p, numel(x));
    if z(i) == 3
        k3 = k3 + 1;
    end
    if z(i) == 4
        k4 = k4 + 1;
    end

    if z(i) == 5
        k5 = k5 + 1;
    end

    if z(i) == 9
        k9 = k9 + 1;
    end
    
end

z'
k3
k4
k5
k9

