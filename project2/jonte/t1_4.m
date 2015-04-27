L = 300;
%f = 0.1/(L*L);
f = 0.0001;
g = 100*f;


timesteps = 1000;

forest = zeros(L);
pvals = zeros(1,timesteps);
colormap copper

for t=1:timesteps
    
    % grow with prob g on empty sites
    forest = or(rand(L) < g, forest);
    
    % lightning season
    strike_sites = find(rand(L) < f);
    forest_clust = bwlabel(forest, 4);
    
    % get the label of the clusters to burn
    killed_clusters = nonzeros(unique(forest_clust(strike_sites)));
    
    % burn the sites belonging to these clusters
    forest = xor(forest, ismember(forest_clust, killed_clusters));
    
    % get forest density
    p = sum(sum(forest))/L^2;
    pvals(t) = p;
    
    % plot
    if (mod(t,10) == 0)
        imagesc(forest)
        title(['t=' num2str(t) ' p=' num2str(p)])
        drawnow
    end   
end

mean(pvals);