% sim. var. aleat. discreta de distrib. generala neuniforma
function xk = SimDiscretN(x, p, n)	% x, p = tablouri

    xk = [];

    % verificarea conditiilor
    for i = 1 : numel(x)-1
        if x(i) > x(i+1)
            fprintf("Eroare! Nu se respecta ordinea crescatoare a valorilor lui x !\n");
            return;
        end
    end
    
    if sum(p) ~= 1
        fprintf("Eroare! Suma probabilitatilor nu este 1 !\n");
        return;
    end

    
	k = 0;
	F = 0;
	u = rand;

	while u >= F
        k = k + 1;
        F = F + p(k);
    end

%     if (k > n)
%         xk = x(k-1);
%         return;
%     end;
    
    xk = x(k);
end