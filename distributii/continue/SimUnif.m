% simularea var. uniforme pe [a,b)
function x = SimUnif(a,b)
    x = [];
    
    % verificarea conditiilor
    if a >= b
        fprintf("Eroare ! Nu se respecta conditia a < b !\n");
        return;
    end

	u = rand;
    x = a + (b-a)*u;
end