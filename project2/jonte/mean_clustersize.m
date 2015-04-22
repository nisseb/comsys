function [S, Q] = mean_clustersize(L, p)
    
    % label the clusters
    [clust, ~] = bwlabel(rand(L) < p, 4);
    
    % get the size of each cluster
    nclust = nonzeros(clust);
    clustsize = hist(nclust, unique(nclust));
    
    Q = hist(clustsize, 1:L^2);
    S = sum(clustsize.^2)/L^2;
end

