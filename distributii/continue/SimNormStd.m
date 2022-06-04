function x = SimNormStd()
    x_rand = zeros(1,12);

    for i = 1 : 12
        x_rand(i) = rand;
    end
    x = sum(x_rand) - 6;
end

