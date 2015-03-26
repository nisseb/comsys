function M = task3()
    
size = 500;
c = 256;
rule = randi([0 1],[1 c]);
%rule = [1 0 0 1];

M = zeros(size-1);
pos = [size / 2, size / 2];
dir = 0;

up =    [-1 0];
right = [0 1];
down =  [1 0];
left =  [0 -1];

limit = 10000000;
i = 1;

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
    
    i = i + 1;
end

colormap(copper)
imagesc(M);

end