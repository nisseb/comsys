function [SE M M_temp Mlab] = perloc2D(L,p)

% Area
A = L*L;

% Setting up M
M = rand(L);
M( M(:)<(1-p) ) = 0;
M( M(:)>=(1-p) ) = 1;
M_temp = M;

% Calculating clusters
M = M + circshift(M,1,1) ...
      + circshift(M,1,2) ...
      + circshift(M,-1,1) ...
      + circshift(M,-1,2);
  
% Only keeping clusters with 1 in middle
M = M.*M_temp;

% Calculating expected cluster area
SE = sum(sum(M))/A;

% Using labeling function

Mlab = bwlabel(M_temp,4);

f1 = figure(1);
imagesc(M_temp);

f2 = figure(2);
imagesc(M);

f3 = figure(3)
imagesc(Mlab);

end