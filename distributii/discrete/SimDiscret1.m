% sim. var. unif. distrib. discret (1)
% pe {0, 1, 2, ..., n-1}
function k = SimDiscretU(n)
	u = rand;
	k = floor(n*u);
end
