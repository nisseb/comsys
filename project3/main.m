close all hidden

%% Simulation parameters
steps = 50000;
n = 199;
p = 0.1; % Initial D
SINB = 0;
DYNB = 0;

%% System parameters

% T>R>P>S
T = 1.9;
R = 1;
P = 0;
S = 0;
rewards = [R S T P];

if SINB
    bvec = 1.75 + 0.3 .* sin(linspace(0,2*pi, steps))
end

if DYNB
    T = 2.05
    dens_ulim = 0.8;
    dens_llim = 0.2;
end

%% Data
dens = zeros(1,steps+1);
%grid = rand(n) < p;
grid = zeros(n);
grid(100,100) = 1;

dens(1) = sum(sum(grid))./(n*n);

colormap([0,0,1;1,1,0;0,1,0;1,0,0])

nn = 0;

%% Main loop
for k = 1:steps
    score = zeros(n);
    prev_grid = 2*grid;
    
    if SINB
        T = bvec(k)
    end
    
    if DYNB && k > 10
        if (mean(dens(1,k-10:k)) < dens_llim)
            T = 1.5
        elseif (mean(dens(1,k-10:k)) > dens_ulim)
            T = 2.05
        end
    end
    
    % Calculate score
    for i = -1:1
        for j = -1:1
            shift_grid = circshift(grid,[i j]);
            temp_grid = shift_grid + 2 * grid;
            score = score + rewards(temp_grid+1);
        end
    end
    
    % Add boundaries
    per_score_grid = padarray(score,[1 1], 'circular');
    per_grid = padarray(grid,[1 1], 'circular');
    
    % Calculate interaction and update grid
    max_offset_grid = nlfilter(per_score_grid, [3 3], ...
                               @(M) max_offset(M,n+2));    
 	max_offset_grid(:) = max_offset_grid(:) + [1:((n+2)*(n+2))]';
    grid = per_grid(max_offset_grid(2:end-1,2:end-1));
    
    % Collect data
    dens(k+1) = 1 - sum(sum(grid))/(n*n);
    
    % Draw system
    % D->D red 3
    % C->D yellow 1
    % D->C green 2
    % C->C blue 0
    imagesc(grid+prev_grid, [0 3])
    drawnow
    
    % Print progress
    msg = ['Step: ' num2str(k) '/' num2str(steps)];
    fprintf(repmat('\b',1,nn));
    fprintf(msg);
    nn=numel(msg);
end

%% Plot data
f2 = figure;
plot(dens, 'LineWidth', 2);
xlabel('Time', 'FontSize', 20)
ylabel('Cooperator density', 'FontSize', 20)
set(gca, 'FontSize', 20);
xlim([1 k]);
ylim([0 1]);

[d_clust, d_n] = bwlabel(grid, 8);
[c_clust, c_n] = bwlabel(not(grid), 8);
fprintf('\n')
disp(['Number of defector clusters: ' num2str(d_n)])
disp(['Number of cooperator clusters: ' num2str(c_n)])
disp(['Final cooperator density: ' num2str(dens(end))])


