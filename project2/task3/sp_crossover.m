function [c1, c2] = sp_crossover(a, b, cross_prob)
% Single points cross over between a and b with
% probability cross_prob

if (rand < cross_prob)
    cp = randi(length(a));
        
    c1 = [a(1:cp) b(cp+1:end)];
    c2 = [b(1:cp) a(cp+1:end)];     
else
    c1 = a;
    c2 = b;
end

end

