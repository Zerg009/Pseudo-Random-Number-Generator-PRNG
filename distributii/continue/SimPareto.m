function y = SimPareto(alpha, beta)
    u = rand;
    y = beta / ((1-u)^(1/alpha));
end