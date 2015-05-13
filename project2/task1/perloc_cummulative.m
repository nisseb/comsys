clear all
close all

L = 800;
pvals = [0.3, 0.592, 0.8];
Q = zeros(length(pvals), L*L);

i = 1;
for p=pvals
    
    % Calling perloc2D function for cluster distribution
    [sE Q(i,:)] = perloc2D(L,p);
    
    % Picking indices != 0 for cumsum and plotting
    idx = find(Q(i,:) > 0);
    
    % Plotting distribution in standard plot and loglog
    f1 = figure(1);
    plot(idx, Q(i,idx), '*', ...
        'DisplayName' , ['p=' num2str(p)]);
    set(gca, 'FontSize', 16)
    hold on
    
    lh1 = legend('-DynamicLegend');
    xlabel('Cluster size', 'FontSize', 20);
    ylabel('Frequency', 'FontSize', 20);
    set(lh1, 'FontSize', 16);
    
    f2 = figure(2);
    loglog(idx,Q(i,idx), '*', ...
        'DisplayName', ['p=' num2str(p)]);
    set(gca, 'FontSize', 16)
    hold on
    
    lh2 = legend('-DynamicLegend');
    xlabel('Cluster size', 'FontSize', 20);
    ylabel('Frequency', 'FontSize', 20);
    set(lh2, 'FontSize', 16);
    
    % Perform cummulative sum
    Q(i,:) = cumsum(Q(i,:), 'reverse');
    
    % Plotting cummulative distribution
    f3 = figure(3);
    loglog(idx,Q(i,idx), '*', ...
        'DisplayName', ['p=' num2str(p)]);
    set(gca, 'FontSize', 16)
    hold on
    
    lh3 = legend('-DynamicLegend');
    xlabel('Cluster size', 'FontSize', 20);
    ylabel('Frequency', 'FontSize', 20);
    set(lh3, 'FontSize', 16);
    
    i = i + 1;
end


