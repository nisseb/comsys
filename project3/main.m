

SINB = 0;
DYNB = 0;

n = 40;
p = 0.1;


grid = rand(n) < p;
prev_grid1 = zeros(n);
prev_grid2 = zeros(n);
prev_grid3 = zeros(n);
% grid = zeros(n)
% grid(50,50) = 1;

score = zeros(n);
per_grid = zeros(n+2);



%% Simulation parameters
f1 = figure(1);
offset = 2;
steps = 300;

%% Data
avg_dens = zeros(1,steps+1);
avg_dens(1,1) = sum(sum(grid))./(n*n);

%% System parameters

% T>R>P>S
T = 1.77;
R = 1;
S = 0;
P = 0;

if SINB
    bvec = 1.75 + 0.3 .* sin(linspace(0,2*pi, steps))
end

if DYNB
    T = 2.05
    dens_ulim = 0.8;
    dens_llim = 0.2;
end


%% Main loop
for k = 1:steps

    score = zeros(n);
    
    prev_grid3 = prev_grid2;
    prev_grid2 = prev_grid1;
    prev_grid1 = grid;
    
    if SINB
        T = bvec(k)
    end
    
    if DYNB
        if (k > 10 && mean(avg_dens(1,k-10:k)) < dens_llim)
            T = 1.5
        elseif (k > 10 && mean(avg_dens(1,k-10:k)) > dens_ulim)
            T = 2.05
        end
    end
    
    % Calculate score
    for i = -1:1
        for j = -1:1
            shift_grid = circshift(grid,[i j]);
            curr_grid = grid .* offset;

            temp_grid = shift_grid + curr_grid;

            % DD
            idx = find(temp_grid == 3);
            score(idx) = score(idx) + P;

            % DC
            idx = find(temp_grid == 2);
            score(idx) = score(idx) + T;

            % CD
            idx = find(temp_grid == 1);
            score(idx) = score(idx) + S;
            
            % CC
            idx = find(temp_grid == 0);
            score(idx) = score(idx) + R;

        end
    end
    
    % 
    per_score_grid = padarray(score,[1 1], 'circular');
    per_grid = padarray(grid,[1 1], 'circular');
    
    % Evolve
    max_offset_grid = nlfilter(per_score_grid, [3 3], ...
                               @(M) max_offset(M,n+2));
    
 	max_offset_grid(:) = max_offset_grid(:) + [1:((n+2)*(n+2))]';
    grid = per_grid(max_offset_grid(2:end-1,2:end-1));
    
    % Collect data
    avg_dens(1,k+1) = 1 - sum(sum(grid))./(n*n);
    
    % Draw system
    imagesc(grid+prev_grid1+prev_grid2+prev_grid3)
    colorbar
    drawnow
    
    k
end

%% Plot data
f2 = figure;
plot(avg_dens, 'LineWidth', 2);
xlabel('Time', 'FontSize', 20)
ylabel('Cooperator density', 'FontSize', 20)
set(gca, 'FontSize', 20);
xlim([1 k]);
ylim([0 1]);



