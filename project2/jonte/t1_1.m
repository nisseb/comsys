Lvals = [50 100 200 300];
prange = [0:0.1:0.5, 0.55:0.001:0.65 0.65:0.05:1];

for L=Lvals
    s = [];

    for p=prange
        s = [s mean_clustersize(L, p)];
    end

    plot(prange, s./L^2)
    hold on
end

xlabel('Probability p')
ylabel('Normalized mean cluster size')

     

