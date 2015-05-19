T = 1.9;
R = 1;
P = 0;
S = 0;

L = 100;
steps = 100;
p = 0.1;

t_min = 1.7;
t_max = 2.1;
n_vals = 10;
Tvals = linspace(t_min,t_max,n_vals);

dens_data = zeros(n_vals, steps+1);
grid_data = zeros(n_vals, L, L);

data = struct;

f1 = figure;
for k=1:length(Tvals)

    rewards = [R S Tvals(k) P];
    [dens_data(k,:), grid_data(k,:,:)] = prisoner_spatial(rewards, L, steps, p);
    
    f1;
    plot(dens_data(k,:), 'DisplayName', num2str(Tvals(k)))
    hold on
    k
end

lh = legend('-DynamicLegend');

data.dens_data = dens_data;
data.grid_data = grid_data;

filename = ['pd_tvals=' num2str(t_min) '-' num2str(t_max) ...
            '_nvals=' num2str(n_vals) '_' ...
            'L=' num2str(L) '_steps=' num2str(steps), '_p=' num2str(p)];
        
filename = strrep(filename, '.', ',');
save(filename, 'data');
