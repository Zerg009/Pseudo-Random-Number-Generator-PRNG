% sim. var. unif. distrib. discret (1)
% pe {0, 1, 2, ..., n-1}
function k = SimDiscretU1(n)
	u = rand;
	k = floor(n*u);     % k in {0, 1, ..., n-1}
end
