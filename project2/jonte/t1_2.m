pvals = [0.3 0.592 0.8];
L = 800;

for p=pvals
    [~, Q] = mean_clustersize(L, p);
    
    % get nonzero indices
    x = find(Q);
    
    % cumulative sum
    cumQ = cumsum(Q(x), 'reverse');
    
    figure(1)
    plot(x, Q(x), 'x')
    hold on
    
    figure(2)
    plot(x, cumQ, 'x')
    hold on
    
    figure(3)
    loglog(x, cumQ, 'x')  
    hold on
end

figure(1)
legend('p = 0.3','p = 0.592','p = 0.8')
xlabel('Cluster size x')
ylabel('Number of clusers of size x')
xlim([0 120])
ylim([0 250])

figure(2)
legend('p = 0.3','p = 0.592','p = 0.8')
xlabel('Cluster size x')
ylabel('Number of clusers of size >= x')
xlim([0 180])
ylim([0 600])

figure(3)
legend('p = 0.3','p = 0.592','p = 0.8')
xlabel('Cluster size x')
ylabel('Number of clusers of size >= x')