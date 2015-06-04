T = 1.9;
R = 1;
P = 0;
S = 0;

L = 200;
steps = 200;
p = 0.1;

%% Tvals
n_vals = 100;
t_min = 1.3;
t_max = 2.3;
Tvals = linspace(t_min,t_max,n_vals);

% Tvals, one in every region
Tvals = [1.4 1.55 1.65 1.78 1.9 2.1];

%% pvals
p = [0.1 0.4 0.7];
idx = 1;


dens_data = zeros(n_vals, steps+1);
grid_data = zeros(n_vals, L, L);

data = struct;

f1 = figure;

for k=1:length(Tvals)

    rewards = [R S Tvals(k) P];
    %[dens_data(k,:), grid_data(k,:,:)] = prisoner_spatial(rewards, L, steps, p(idx));

    f1;
    plot(dens_data(k,:), 'DisplayName', num2str(Tvals(k)))
    hold on
    disp(['k = ' num2str(k)]);
end

set(gca, 'FontSize', 16)
xlabel('Time', 'FontSize', 20)
ylabel('C density', 'FontSize', 20)
lh = legend('-DynamicLegend');
set(lh, 'FontSize', 16);

data.dens_data = dens_data;
data.grid_data = grid_data;

filename = ['pd_relevant_tvals_L=' num2str(L) '_steps=' ...
            num2str(steps), '_p=' num2str(p(idx))];
        
filename = strrep(filename, '.', ',');
save(filename, 'data');
