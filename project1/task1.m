function M = task1( rule )

if (length(rule) == 1)
    rule = de2bi(rule, 8);
end

size = 128;

M = zeros(size-1);
M(1, size/2) = 1;

for i=2:size-1
    for j=2:size-2
        vec = fliplr(M(i-1, j-1:j+1));
        r = bi2de(vec);
        M(i,j) = rule(r+1);
    end
end

f1 = figure(1);
colormap gray;
imagesc(M(1:(size-2)/2,:));

saveas(f1, ['figs/t1p1/ca_rule_' num2str(bi2de(rule)) '.eps'], 'epsc');

end