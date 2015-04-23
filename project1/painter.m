%% SIMULATION PARAMETERS
SIZE = 500;
MAX_STEPS = 11000000000;
UPDATE_INTERVAL = 1000;

% Defines the painter behaviour on each color i
% turn_rule(i) : behaviour
%          -1  : turn left
%           1  : turn right
%           2  : turn back
%           0  : do nothing
turn_rule = [1 -1 -1 1];
%turns = [-1 1];
%turn_rule = turns(1+floor(rand(1,100) * length(turns)))

%% RUN
n = length(turn_rule);
x = SIZE/2;
y = SIZE/2;
dir = 0;
grid = zeros(SIZE);

colormap copper
i = 0;
while (i < MAX_STEPS)
    % update current square
    val = grid(y,x);
    grid(y,x) = mod(val+1, n);
  
    % turn
    dir = mod(dir+4+turn_rule(val+1), 4);
    
    % move to next square
    if (dir == 0)
        y = 1+mod(y+SIZE-2, SIZE);
    elseif (dir == 2)
        y = 1+mod(y+SIZE, SIZE);
    elseif (dir == 1)
        x = 1+mod(x+SIZE, SIZE);
    elseif (dir == 3)
        x = 1+mod(x+SIZE-2, SIZE);
    end
  

    i=i+1;
    if (mod(i, UPDATE_INTERVAL) == 0)
      imagesc(grid);
      title(num2str(i))
      drawnow
    end
end

set(gca,'YTick',[]);
set(gca,'XTick',[]);
title('')

  
  