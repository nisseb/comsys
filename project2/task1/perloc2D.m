function [sE Q] = perloc2D(L,p)
% returns expected value of clustes size: variable sE and area size distribution Q

% Area
A = L*L;

% Setting up M
M = rand(L) < p;

% Using labeling function
clust = bwlabel(M,4);

% Get cluster data
nclust = nonzeros(clust);
clustsize = hist(nclust, unique(nclust));
    
Q = hist(clustsize, 1:L^2);
sE = sum(clustsize.^2)/L^2;

end