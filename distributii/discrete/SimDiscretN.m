% sim. var. aleat. discreta de distrib. generala neuniforma
function xk = SimDiscretN(x, p, n)	% x, p = tablouri
	k = 1;
	F = p(1);
	u = rand;
	while u >= F
        F = F + p(k);
		k = k + 1;
    end

    if (k > n)
        xk = x(k-1);
        return;
    end;
    
    xk = x(k);
end