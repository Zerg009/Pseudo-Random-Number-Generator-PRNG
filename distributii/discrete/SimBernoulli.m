% sim. var. Bernoulli
function y = SimBernoulli(p)
	u = rand;
	if u < p 
        y = 1;
	else 
        y = 0;
    end
end