% Clear all and close all before running. Produces plots from datafiles
% with all chosen p. Has "hold on" on figures.

%% 
% pstr = num2str(p);
% pstr = strrep(pstr,'.',',');

p1 = load('data/pd_relevant_tvals_L=200_steps=200_p=0,1.mat');
p4 = load('data/pd_relevant_tvals_L=200_steps=200_p=0,4.mat');
p7 = load('data/pd_relevant_tvals_L=200_steps=200_p=0,7.mat');

p = [p1.data p4.data p7.data];
%close all

n = size(p(1).dens_data);
n = n(1)
L = 200;
len = size(p(1).dens_data);
len = len(2)

Tvals = [1.4 1.55 1.65 1.78 1.9 2.1];
pvals = [0.1 0.4 0.7];

f = [];

%% Plot density 
final_dens = zeros(length(p), n);
for l=1:length(p)
    for k=1:n
        final_dens(l,k) = mean(p(l).dens_data(k, len-25:len));
    end
end

f1 = figure(1);
x = 1:n;
y = [final_dens(1,:); final_dens(2,:); final_dens(3,:)]';
bh1 = bar(x, y);
set(bh1,{'DisplayName'}, {['p = 0.1']; ['p = 0.4']; ['p = 0.7']})
legend('-DynamicLegend')

set(gca, 'XTick', 1:n, 'XTickLabel', Tvals, 'FontSize', 16')

xlabel('Defector to Cooperator reward')
ylabel('Equilibrium C density')

%% Plot cluster counts
deffector_clusters = zeros(length(p),n);
cooperator_clusters = zeros(length(p), n);
for l=1:length(p)
    for k=1:n
        grid = reshape(p(l).grid_data(k,:,:), [L L]);
        [~, deffector_clusters(l,k)] = bwlabel(grid, 8);
        [~, cooperator_clusters(l,k)] = bwlabel(not(grid), 8);
    end
end

f2 = figure(2);
x = 1:n;
y = [cooperator_clusters(1,:); cooperator_clusters(2,:); cooperator_clusters(3,:)]';
bh2 = bar(x, y);

set(bh2,{'DisplayName'}, {['p = 0.1']; ['p = 0.4']; ['p = 0.7']})
legend('-DynamicLegend')

set(gca, 'XTick', 1:n, 'XTickLabel', Tvals, 'FontSize', 16')

xlabel('Defector to Cooperator reward')
ylabel('Number of clusters')

% Show grid
% figure(3)
% colormap([0,0,0;1,1,1])
% for k=1:n
%     grid = reshape(p(1).grid_data(k,:,:), [L L]);
%     imagesc(grid, [0 1])
%     title(['T = ' num2str(Tvals(k))])
%     drawnow
%     pause(0.2)
% end
figs = [];
for l=1:length(p)
    for k=1:n
        f = figure;
        colormap([0,0,0;1,1,1])
        figs = [figs f];
        grid = reshape(p(l).grid_data(k,:,:), [L L]);
        imagesc(grid, [0 1])
        title(['T = ' num2str(Tvals(k)) ', p = ' num2str(pvals(l))])
        %drawnow
        %pause(0.2)
        dir = ['figs/grid_figs/'];
        figname = ['T=' num2str(Tvals(k)) 'p=' num2str(pvals(l))];
        figname = strrep(figname, '.', ',');
        %saveas(f, [dir figname],'png')
        close(f)
    end
end





