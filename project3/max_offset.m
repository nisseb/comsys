function i = max_offset(M,n)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[row, col] = find( M == max(max(M)), 1 );
row = row - 2;
col = col - 2;
i = col*n+row;

end

