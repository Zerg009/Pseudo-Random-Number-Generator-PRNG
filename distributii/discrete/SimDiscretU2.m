% sim. unei var. uniform distrib. discret (2)
% pe {m, ..., n}
function k = SimDiscretU2(m, n)
	u = rand();
	k = floor((n-m+1)*u);	% k in {0, ..., n} | +m
	k = k+m;                % k in {m, ..., n}
end