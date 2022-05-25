% sim. var. binomiale
function x = SimBinom(p, n)
    u = rand(1,n)
    x = sum(u<p)
end