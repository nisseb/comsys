% Task 1

% Initial setup
Lvals = [20 50 100 200 300];
pvals = [0:0.5:0.55 0.555:0.005:0.625 0.63:0.02:0.67 0.7:0.1:1];
sE = zeros(length(Lvals),length(pvals));

f1 = figure(1);

j = 1;

% Outer loop running for different values of L
for L=Lvals
    
    i = 1;
    
    % Inner loop running perloc2D and dynamic plotting
    for p=pvals
        [sE(j,i) Q] = perloc2D(L,p);
        i = i + 1;
    end
    
    % Result plotter
    plot(pvals,sE(j,:)./(L*L), 'Linewidth', 1, 'Marker', '*', ...
        'DisplayName', ['L=' num2str(L)]);
    hold on
    
    lh = legend('-DynamicLegend');
    set(lh, 'FontSize', 16, 'Location', 'best');
    
    xlabel('probability p', 'FontSize', 20);
    ylabel('Expected cluster size', 'FontSize', 20);
    set(gca, 'FontSize', 16);
    
    j = j + 1;
end

hold off




