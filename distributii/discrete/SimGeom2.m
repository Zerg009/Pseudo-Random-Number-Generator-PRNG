% simularea var. geom. (2)
function x = SimGeom2(p)
    u = rand;
	x = floor(log(1-u)/log(1-p)) + 1;
end