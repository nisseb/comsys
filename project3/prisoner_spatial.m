function [dens, grid] = prisoner_spatial(rewards, n, steps, p, PLOT, MEM)
% rewards should be [R S T P]
% n size of grid
% p initial deffector density
% steps simulation time steps
% p cooperator density (random positioning)
% PLOT produces grid plot during simulation
% MEM uses bimodal states (1 step memory)

if nargin < 6
    MEM = 0;
end

if nargin < 5
    PLOT = 0;
end

%% Data
dens = zeros(1,steps+1);
grid = rand(n) < p;
dens(1) = sum(sum(grid))./(n*n);
mem_grid = zeros(n);

if PLOT 
    colormap([0,0,1;1,1,0;0,1,0;1,0,0])
end

%% Main loop
for k = 1:steps
    score = zeros(n);
    prev_grid = grid;
    
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
    max_offset_grid = zeros(n+2);
    for i=2:n+1
        for j=2:n+1
            nhood = per_score_grid(i-1:i+1,j-1:j+1);
            max_offset_grid(i, j) = max_offset(nhood, n+2);
        end
    end
    
 	max_offset_grid(:) = max_offset_grid(:) + [1:((n+2)*(n+2))]';
    
    if MEM
        % New proposed grid
        new_grid = per_grid(max_offset_grid(2:end-1,2:end-1));

        % 1:s if change is good
        temp_grid = xor(grid, new_grid);

        % Identify where to change (2:s) and set new grid
        mem_grid = mem_grid + temp_grid;
        idx = find(mem_grid == 2);
        grid(idx) = new_grid(idx);

        % Set 2:s to 1:s in mem_grid
        mem_grid(mem_grid == 2) = 1;

        % Set 1:s to 0:s (weak to strong)
        idx2 = find(temp_grid == 0);
        mem_grid(idx2) = 0;
    else
        grid = per_grid(max_offset_grid(2:end-1,2:end-1));
    end
    
    % Collect data
    dens(k+1) = 1 - sum(sum(grid))/(n*n);
    
    % Draw system
    % D->D red 3
    % C->D yellow 1
    % D->C green 2
    % C->C blue 0
    if PLOT
        imagesc(grid+2*prev_grid, [0 3])
        title(num2str(k))
        drawnow
    end
end


