T = 1.9;
R = 1;
P = 0;
S = 0;
rewards = [R S T P];

[dens, grid] = prisoner_spatial(rewards, 100, 50, 0.1, true);

%% Plot data
f2 = figure;
plot(dens, 'LineWidth', 2);
xlabel('Time', 'FontSize', 20)
ylabel('Cooperator density', 'FontSize', 20)
set(gca, 'FontSize', 20);
xlim([1 51]);
ylim([0 1]);

[d_clust, d_n] = bwlabel(grid, 8);
[c_clust, c_n] = bwlabel(not(grid), 8);
fprintf('\n')
disp(['Number of defector clusters: ' num2str(d_n)])
disp(['Number of cooperator clusters: ' num2str(c_n)])
disp(['Final cooperator density: ' num2str(dens(end))])