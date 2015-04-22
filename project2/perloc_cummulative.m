%Task 2

clear all
close all

L = 200;
%L = 800;
pvals = [0.3, 0.592, 0.8];

Q = zeros(length(pvals), L*L);

i = 1;
for p=pvals
    
    % Calling perloc2D function for cluster distribution
    [sE Q(i,:)] = perloc2D(L,p);
    
    % Picking indices != 0 for cumsum and plotting
    idx = find(Q(i,:) > 0);
    
    % Plotting distribution in standard plot
    f1 = figure(1);
    plot(idx, Q(i,idx), '*', ...
        'DisplayName' , ['p=' num2str(p)]);
    hold on
    
    xlabel('Cluster size', 'FontSize', 20);
    ylabel('Frequency', 'FontSize', 20);
    legend('-DynamicLegend');
    
    % Plotting distribution in log-log plot
    f2 = figure(2);
    loglog(idx,Q(i,idx), '*', ...
        'DisplayName', ['p=' num2str(p)]);
    hold on
    
    xlabel('Cluster size', 'FontSize', 20);
    ylabel('Frequency', 'FontSize', 20);
    legend('-DynamicLegend');
    
    % Perform cummulative sum
    Q(i,:) = cumsum(Q(i,:), 'reverse');
    
    % Plotting cummulative distribution
    f3 = figure(3);
    loglog(idx,Q(i,idx), '*', ...
        'DisplayName', ['p=' num2str(p)]);
    hold on
    
    xlabel('Cluster size', 'FontSize', 20);
    ylabel('Frequency', 'FontSize', 20);
    legend('-DynamicLegend');
    
    i = i + 1;
end

hold off