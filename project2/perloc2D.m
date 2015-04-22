function [sE Q] = perloc2D(L,p)
% returns expected value of clustes size: variable sE and area size distribution Q

% Area
A = L*L;

% Setting up M
M = rand(L);
M( M(:)<(1-p) ) = 0;
M( M(:)>=(1-p) ) = 1;

% Using labeling function
Mlab = bwlabel(M,4);

% Calculating expected value and cluster distribution
sE = zeros(1, max(max(Mlab)));
Q = zeros(1, L*L);
for i = 1:max(max(Mlab))
    sE(i) = length(Mlab(Mlab(:) == i));
    Q(sE(i)) = Q(sE(i)) + 1;
end

sE = sum( sE.^2./A );
end