load('data/pd_tvals=1,7-2,1_nvals=100_L=400_steps=300_p=0,1.mat')
%load('data/pd_tvals=1,0-1,7_nvals=100_L=400_steps=300_p=0,1.mat')
close all

Tvals = linspace(1.7, 2.1, 100);

%% Plot density 
final_dens = zeros(1, 100);
for k=1:100
    final_dens(k) = mean(data.dens_data(k, 250:301));
end

figure(1)
plot(Tvals, final_dens)
xlabel('T - reward for D against C')
ylabel('Equilibrium C density')

%% Plot cluster counts
deffector_clusters = zeros(1,100);
cooperator_clusters = zeros(1, 100);
for k=1:100
    grid = reshape(data.grid_data(k,:,:), [400 400]);
    [~, deffector_clusters(k)] = bwlabel(grid, 8);
    [~, cooperator_clusters(k)] = bwlabel(not(grid), 8);
end

figure(2)
plot(Tvals, deffector_clusters, Tvals, cooperator_clusters)
xlabel('T - reward for D against C')
ylabel('Number of clusters')
legend('Deffector','Cooperator')

%% Show grid
colormap([0,0,0;1,1,1])
for k=1:100
    grid = reshape(data.grid_data(k,:,:), [400 400]);
    imagesc(grid, [0 1])
    title(['T = ' num2str(Tvals(k))])
    drawnow
    pause(0.2)
end