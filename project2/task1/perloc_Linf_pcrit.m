clear all
close all

%% Initial parameters

L = 400;
p = 0.592;
x_min = 6;
iterations = 20;
Q = zeros(iterations, L*L);
Qc = zeros(iterations, L*L);

%% Perform main loop to obtain Q

for i=1:iterations
    
    % Calling perloc2D function to obtain cluster distribution
    [sE Q(i,:)] = perloc2D(L,p);
    
    % Perform cummulative sum
    Qc(i,:) = cumsum(Q(i,:), 'reverse');
end

%% Mean Q & Qc

mQ = mean(Q);
mQc = mean(Qc);

midx = find(mQ > 1);
midx = midx(x_min+1:end);

%% Calculate alpha, C and standard deviation sigma

n = 0;
tempsum = 0;

for i=1:iterations
    idx = find(Q(i, x_min+1:end) > 0) + x_min;
    
    n = n + sum(Q(i,idx));
    tempsum = tempsum + sum( Q(i,idx).*log(idx./(idx(1)-0.5)) );
end

alpha = 1 + n * tempsum^(-1);

temp = mQ(midx).*(midx.^(alpha));
C = mean(temp);
vals = C .* midx.^(-alpha);

sigma = (alpha-1)/sqrt(n);

%% Display values
disp(['alpha = ' num2str(alpha)]);
disp(['C = ' num2str(C)]);
disp(['sigma = ' num2str(sigma)]);

%% Plot figures

% Regular distribution
f2 = figure(2);
loglog(midx,mQ(midx), '*', ...
    'DisplayName', ['Regular']);
set(gca, 'FontSize', 16)
hold on

% Cummulative distribution
figure(2);
loglog(midx,mQc(midx), '*', ...
    'DisplayName', ['Cumulative']);
set(gca, 'FontSize', 16)
hold on

% Fitted curve
figure(2);
loglog(midx, vals, 'LineWidth', 2, ...
    'DisplayName', ['alpha = ' num2str(alpha)], 'Color', [0 0.75 0]);

lh3 = legend('-DynamicLegend');
xlabel('Cluster size', 'FontSize', 20);
ylabel('Frequency', 'FontSize', 20);
set(lh3, 'FontSize', 16, 'Location', 'best');

xlim([0 midx(end)+10])
ylim([1e-1 1e4])

