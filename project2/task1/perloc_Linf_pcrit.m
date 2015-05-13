

clear all
close all

%% Initial parameters

L = 800;
p = 0.592;
iterations = 2;
Q = zeros(iterations, L*L);
Qc = zeros(iterations, L*L);


%% Perform main loop to obtain Q

for i=1:iterations
    
    % Calling perloc2D function for cluster distribution
    [sE Q(i,:)] = perloc2D(L,p);
    
    % Picking indices != 0 for cumsum and plotting
    % idx = find(Q(i,:) > 0);
    
    % Perform cummulative sum
    Qc(i,:) = cumsum(Q(i,:), 'reverse');
    
    i
end

%% Mean Q

mQ = mean(Q);
mQc = mean(Qc);


%% Calculate alpha

x_min = 6;
n = 0;
tempsum = 0;

for i=1:iterations
    idx = find(Q(i, x_min+1:end) > 0) + x_min;
    
    n = n + sum(Q(i,idx));
    tempsum = tempsum + sum( Q(i,idx).*log(idx./(idx(1)-0.5)) );
end

alpha = 1 + n * tempsum^(-1);

%midx = find(mQ(x_min+1:end)) + x_min;
temp = Q(i,idx)./sum(Q(i,idx)).*idx.^(alpha);
C = mean(temp);

vals = C .* idx.^(-alpha);

% ./sum(mQ(midx))


%% Display values
disp(['alpha = ' num2str(alpha)]);
disp(['C = ' num2str(C)]);

%% Plot figures

% R?nka ut nytt index

% Plotting regular distribution
f1 = figure(2);
loglog(idx,mQ(idx), '*', ...
    'DisplayName', ['Regular']);
set(gca, 'FontSize', 16)
hold on

lh3 = legend('-DynamicLegend');
xlabel('Cluster size', 'FontSize', 20);
ylabel('Frequency', 'FontSize', 20);
set(lh3, 'FontSize', 16);

% Plotting cummulative distribution
f2 = figure(2);
loglog(idx,mQc(idx), '*', ...
    'DisplayName', ['Cumulative']);
set(gca, 'FontSize', 16)
hold on

lh3 = legend('-DynamicLegend');
xlabel('Cluster size', 'FontSize', 20);
ylabel('Frequency', 'FontSize', 20);
set(lh3, 'FontSize', 16);

% get indices for plotting
% idx_max = idx(1);
% idx_min = find(mQ > 1, 1, 'last');
% 
% x = logspace(log10(mQ(idx_max)), log10(mQ(idx_min)), 100);

f2 = figure(2);
loglog(idx, vals, 'LineWidth', 2, ...
    'DisplayName', ['Approx']);

xlabel('Cluster size', 'FontSize', 20);
ylabel('Frequency', 'FontSize', 20);
set(lh3, 'FontSize', 16);