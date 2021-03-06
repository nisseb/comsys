function n = iphone_3(N, q, timesteps, plotit)

if (nargin < 4)
    plotit = 0;
end

y = zeros(1, timesteps);  % number of iphone users
y(1) = floor(N/2);  % intitial condition

for t=2:timesteps
    y(t) = y(t-1);
    iphone = 0;
    
    if (rand < y(t)/N) % we chose iPhone user
        y(t)=y(t)-1; % phone breaks down 
        iphone = 1;
    end
    
    if (rand < q)
        if (rand < 0.5)
            y(t)=y(t)+1; % buy an iphone
        end
    else
        draw1 = (rand < y(t)/(N-1));
        draw2 = (rand < (y(t)-draw1)/(N-2));
        
        if (draw1 == draw2)
            y(t)=y(t)+draw1;
        else
            y(t)=y(t)+iphone;
        end
    end
end

if plotit
    plot(y)
    xlabel('Timestep')
    ylabel('iPhone users')
    m = mean(y(timesteps/2:end));
    disp(['Mean of second half: ' num2str(m)])
end

n = y(end);
end
