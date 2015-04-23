


L = 1000; 
f = 0.1/(L^2); 
g = 10000*f;

steps = 300;

growth = zeros(L);
forest = zeros(L);
clusters = zeros(L);
lightning = zeros(L);

i = 1;
while (i < steps)
    
    growth = rand(L) < g;
    forest = or(forest, growth);
    
    lightning = rand(L) < f;
    l_idx = find(L);
    clusters = bwlabel(forest);
    
    lsc = nonzeros(unique(clusters(l_idx)));
    
    forest = xor(forest, ismember(clusters, lsc));
    
    if (mod(i,50) == 0)
        td = sum(sum(forest)) / (L*L);
        imagesc(forest);
        title(['Timestep: ' num2str(i), ...
               ', Tree distribution: ' num2str(td)]);
        colormap hot
        drawnow
    end
    
    i = i + 1;
end
