function res = pvals_plotter(p)
% Clear all and close all before running. Produces plots from datafiles
% with all chosen p. Has "hold on" on figures.

%% 
pstr = num2str(p);
pstr = strrep(pstr,'.',',');
load(['data/pd_tvals=1,3-2,3_nvals=100_L=200_steps=200_p=' pstr '.mat'])
%load('data/pd_tvals=1,7-2,1_nvals=100_L=400_steps=300_p=0,1.mat')
%load('data/pd_tvals=1,0-1,7_nvals=100_L=400_steps=300_p=0,1.mat')
%close all

n = 100;
L = 200;
len = length(data.dens_data(1,:))

Tvals = linspace(1.3, 2.3, n);

%% Plot density 
final_dens = zeros(1, n);
for k=1:n
    final_dens(k) = mean(data.dens_data(k, len-25:len));
end

figure(1)
plot(Tvals, final_dens, 'DisplayName', ['p = ' pstr], ...
     'LineWidth', 1)
xlabel('T - reward for D against C')
ylabel('Equilibrium C density')
legend('-DynamicLegend')

hold on

%% Plot cluster counts
deffector_clusters = zeros(1,n);
cooperator_clusters = zeros(1, n);
for k=1:n
    grid = reshape(data.grid_data(k,:,:), [L L]);
    [~, deffector_clusters(k)] = bwlabel(grid, 8);
    [~, cooperator_clusters(k)] = bwlabel(not(grid), 8);
end

figure(2)
%plot(Tvals, deffector_clusters, Tvals, cooperator_clusters)
plot(Tvals, cooperator_clusters, 'DisplayName', ['p = ' pstr], ...
     'LineWidth', 1)
xlabel('T - reward for D against C')
ylabel('Number of clusters')
legend('-DynamicLegend')

hold on

%% Show grid
% figure(3)
% colormap([0,0,0;1,1,1])
% for k=1:n
%     grid = reshape(data.grid_data(k,:,:), [L L]);
%     imagesc(grid, [0 1])
%     title(['T = ' num2str(Tvals(k))])
%     drawnow
%     pause(0.2)
% end

res = final_dens;

end