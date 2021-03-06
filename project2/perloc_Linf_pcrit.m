

clear all
close all

L = 2000;
p = 0.592;
iterations = 10;
Q = zeros(iterations, L*L);
Qc = zeros(iterations, L*L);

for i=1:iterations
    
    % Calling perloc2D function for cluster distribution
    [sE Q(i,:)] = perloc2D(L,p);
    
    % Picking indices != 0 for cumsum and plotting
    idx = find(Q(i,:) > 0);
    
    % Perform cummulative sum
    Qc(i,:) = cumsum(Q(i,:), 'reverse');
    
    i
end

mQ = mean(Q);
mQc = mean(Qc);

% Plotting regular distribution
f1 = figure(2);
loglog(mQ, '*', ...
    'DisplayName', ['Regular']);
set(gca, 'FontSize', 16)
hold on

lh3 = legend('-DynamicLegend');
xlabel('Cluster size', 'FontSize', 20);
ylabel('Frequency', 'FontSize', 20);
set(lh3, 'FontSize', 16);

% Plotting cummulative distribution
f2 = figure(2);
loglog(mQc, '*', ...
    'DisplayName', ['Cumulative']);
set(gca, 'FontSize', 16)
hold on

lh3 = legend('-DynamicLegend');
xlabel('Cluster size', 'FontSize', 20);
ylabel('Frequency', 'FontSize', 20);
set(lh3, 'FontSize', 16);

idx = find(mQ >= 6);
idx_max = idx(1);
idx_min = idx(end);

n = length(idx);
alpha = 1 + n * ( sum( log10(mQ(idx)./mQ(idx_min)) ) )^(-1)

x = logspace(log10(mQ(idx_max)), log10(mQ(idx_min)), 100);
vals = mQ(1) .* idx.^(-alpha);

f2 = figure(2);
loglog(idx, vals, 'LineWidth', 2, ...
    'DisplayName', ['Approx']);

xlabel('Cluster size', 'FontSize', 20);
ylabel('Frequency', 'FontSize', 20);
set(lh3, 'FontSize', 16);