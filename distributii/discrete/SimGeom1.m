% simularea var. geom. (1)
function k = SimGeom1(p)
	k = 0;
	
	while 1
        u = rand;
		k = k + 1;

        if u < p
            break;
        end
    end

end