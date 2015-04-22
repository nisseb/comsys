function [sE] = perloc2D(L,p)
% returns expected value of s: variable sE

% Area
A = L*L;

% Setting up M
M = rand(L);
M( M(:)<(1-p) ) = 0;
M( M(:)>=(1-p) ) = 1;

% Using labeling function
Mlab = bwlabel(M,4);

% Calculating expected value
sE = zeros(1, max(max(Mlab)));
for i = 1:max(max(Mlab))
    sE(i) = length(Mlab(Mlab(:) == i));
end

sE = sum( sE.^2./A );
end