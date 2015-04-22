function M = task3(rule)
    
size = 600;
rule = randi([0 1],[1 256]);
%rule = [1 0 0 1]
%rule = [1 0 0 1 0 1 1 0];
%rule = [0 1 1 0];
%rule = [0 1 1 0 1 0 0 1 1 0 0 1 0 1 1 0];
%rule = [1 1 0 0 0 0 1 1];
c = length(rule);


M = zeros(size-1);
pos = [size / 2, size / 2];
dir = 0;

up =    [-1 0];
right = [0 1];
down =  [1 0];
left =  [0 -1];

limit = 10000000;
i = 1;

f1 = figure(1);
colormap(copper)

while (i <= limit)
    
    M(pos(1), pos(2)) = mod(M(pos(1), pos(2)) + 1,c);
    
    if (rule(M(pos(1), pos(2)) + 1) == 0)
        dir = mod(dir-1,4);
    else
        dir = mod(dir+1,4);
    end
    
    if (dir == 0)
        pos = pos + up;
    elseif (dir == 1)
        pos = pos + right;
    elseif (dir == 2)
        pos = pos + down;
    elseif (dir == 3)
        pos = pos + left;
    end
    
    % Periodic boundaries
    if (pos(1) < 1)
        pos(1) = size-1;
    end
    if (pos(1) > size-1)
        pos(1) = 1;
    end
    if (pos(2) < 1)
        pos(2) = size-1;
    end
    if (pos(2) > size-1)
        pos(2) = 1;
    end
    
    i = i + 1;
end

imagesc(M);
r = num2str(rule);
r = strrep(r, ' ', '');

saveas(f1, ['figs/t1p3/t3_painter_rule_' r '.eps'], 'epsc');

end