% forest size L*L sites
L = 1000;

% f probability of site being struck by lightnings
f = 0.1/(L*L);
% g probability of tree growth per site
g = 10000*f;


timesteps = 10000;

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
    %p = sum(sum(forest))/L^2;
    %pvals(t) = p;
    
    % plot
    if (mod(t,10) == 0)
        p = sum(sum(forest))/L^2;
        pvals(t) = p;
        imagesc(forest)
        title(['t=' num2str(t) ' p=' num2str(p)])
        drawnow
    end   
end

figure(2)
plot(nonzeros(pvals))
