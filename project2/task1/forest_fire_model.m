


L = 300;
f = 0.1/(L^2); 
g = 10000*f;

steps = 50000;

growth = zeros(L);
forest = zeros(L);
clusters = zeros(L);
lightning = zeros(L);

td_data = zeros(1,steps);

f1 = figure(1);

i = 1;
while (i < steps)
    
    growth = rand(L) < g;
    forest = or(forest, growth);
    
    lightning = rand(L) < f;
    l_idx = find(lightning);
    clusters = bwlabel(forest);
    
    lsc = nonzeros(unique(clusters(l_idx)));
    
    forest = xor(forest, ismember(clusters, lsc));
    
    td = sum(sum(forest)) / (L*L);
    
    if (mod(i,100) == 0)
        imagesc(forest);
        title(['Timestep: ' num2str(i), ...
               ', Tree distribution: ' num2str(td)]);
        colormap hot
        drawnow
    end
    
    td_data(1,i) = td;
    
    i = i + 1
end

f2 = figure(2);
plot(td_data, 'LineWidth', 2);
xlabel('Time t', 'FontSize', 20)
ylabel('Density p', 'FontSize', 20)
set(gca, 'FontSize', 16)
xlim([0 20000])
ylim([0 1])

%saveas(f2, 'figs/ff_dens.eps', 'epsc')


