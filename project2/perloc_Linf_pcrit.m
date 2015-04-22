

clear all
close all

L = 800;
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
    
    % Plotting cummulative distribution
%     f3 = figure(3);
%     loglog(idx,Qc(i,idx), '*', ...
%         'DisplayName', ['p=' num2str(p)]);
%     set(gca, 'FontSize', 16)
%     hold on
%     
%     lh3 = legend('-DynamicLegend');
%     xlabel('Cluster size', 'FontSize', 20);
%     ylabel('Frequency', 'FontSize', 20);
%     set(lh3, 'FontSize', 16);
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


