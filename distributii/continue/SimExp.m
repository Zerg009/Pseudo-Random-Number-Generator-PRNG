% simularea var. exponentiale
function x = SimExp(theta)
	u = rand;
	x = -theta * log(1-u);
end