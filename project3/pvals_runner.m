T = 1.9;
R = 1;
S = 0;

n = 40;
steps = 100;
p = 0.1;

n_vals = 10;
Pvals = linspace(0,0.5,n_vals);

dens_data = zeros(n_vals, steps+1);
grid_data = zeros(n_vals, n, n);

for k=1:length(Pvals)

    rewards = [R S T Pvals(k)];
    [dens_data(k,:), grid_data(k,:,:)] = prisoner_spatial(rewards, n, steps, p, true);
    
end

plot(dens_data')
