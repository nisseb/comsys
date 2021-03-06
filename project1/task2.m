function M = task2()
    
size = 100;

M = zeros(size-1);
pos = [size / 2, size / 2];
dir = 0;

up =    [-1 0];
right = [0 1];
down =  [1 0];
left =  [0 -1];

M(size/2, size/2) = 1;

limit = 11000;
i = 1;

while (i <= limit)
    
    if (M(pos(1), pos(2)) == 0)
        M(pos(1), pos(2)) = 1;
        dir = mod(dir-1,4);
    else
        M(pos(1), pos(2)) = 0;
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

f1 = figure(1);
colormap gray
imagesc(M);

%saveas(f1, ['figs/t1p2/t2_painter_rule_2' '.eps'], 'epsc');

end

