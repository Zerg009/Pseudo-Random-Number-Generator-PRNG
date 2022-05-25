% simularea unui punct in dreptunghi
function [x y] = SimPointInRectangle(a, b, c, d)
    x = a + (b-a)*rand;
    y = c + (d-c)*rand;
end
