function [dens, grid] = prisoner_spatial(rewards, n, steps, p, PLOT)
% rewards should be [R S T P]
% n size of grid
% p initial deffector density

if nargin < 5
    PLOT = 0;
end

%% Simulation parameters
SINB = 0;
DYNB = 0;

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
grid = rand(n) < p;
dens(1) = sum(sum(grid))./(n*n);

if PLOT 
    colormap([0,0,1;1,1,0;0,1,0;1,0,0])
end

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
    max_offset_grid = zeros(n+2);
    for i=2:n+1
        for j=2:n+1
            nhood = per_score_grid(i-1:i+1,j-1:j+1);
            max_offset_grid(i, j) = max_offset(nhood, n+2);
        end
    end
    
 	max_offset_grid(:) = max_offset_grid(:) + [1:((n+2)*(n+2))]';
    grid = per_grid(max_offset_grid(2:end-1,2:end-1));
    
    % Collect data
    dens(k+1) = 1 - sum(sum(grid))/(n*n);
    
    % Draw system
    % D->D red 3
    % C->D yellow 1
    % D->C green 2
    % C->C blue 0
    if PLOT
        imagesc(grid+prev_grid, [0 3])
        title(num2str(k))
        drawnow
    end
end

