% sim. var. Bernoulli
function y = Bernoulli(p)
	u = rand;
	if u < p 
        return 1;
	else 
        return 0;
    end;
end