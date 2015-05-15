
% Number of avals
M = 4;
% Number of evals
N = 4;

% number of means
avg = 5;

avals = linspace(0,pi,M);
evals = linspace(0,pi,N);

pol = zeros(M,N);
apol = zeros(M,N);

for i=1:M
    for j=1:N
        
        temp = zeros(avg,2);
        for k = 1:avg
            [temp(k,1), temp(k,2)] = spp(avals(i),evals(j), 0);
        end
        
        pol(i,j) = mean(temp(:,1));
        apol(i,j) = mean(temp(:,2));
        
        [i j]
    end
end

pol = pol';
apol = apol';

pol = flipud(pol);
apol = flipud(apol);

pi_lab = texlabel('pi');
strx = {'0'; pi_lab};
stry = {pi_lab;'0'};

f1 = figure(1);
imagesc(pol);
xlabel('alpha', 'FontSize', 20);
ylabel('noise', 'FontSize', 20);
set(gca, 'FontSize', 20, ...
         'XTick', [0.1 pi-0.1].*20./pi, 'XTickLabel',strx, ...
         'YTick', [0.1 pi-0.1].*20./pi, 'YTickLabel',stry);
colorbar
f2 = figure(2);
imagesc(apol);
xlabel('alpha', 'FontSize', 20);
ylabel('noise', 'FontSize', 20);
set(gca, 'FontSize', 20, ...
         'XTick', [0.1 pi].*20./pi, 'XTickLabel',strx, ...
         'YTick', [0.1 pi].*20./pi, 'YTickLabel',stry);
colorbar
%str,'fontname','symbol'

% h1 = HeatMap(pol');
% xh1 = addXLabel(h1, 'avals');
% yh1 = addYLabel(h1, 'evals');
% set(xh1, 'FontSize', 20);
% set(yh1, 'FontSize', 20);
% 
% h2 = HeatMap(apol');
% xh2 = addXLabel(h2, 'avals');
% yh2 = addYLabel(h2, 'evals');
% set(xh2, 'FontSize', 20);
% set(yh2, 'FontSize', 20);
