function n = iphone(N, p, timesteps, plotit)

if (nargin < 4)
    plotit = 0;
end

y = zeros(1, timesteps);  % number of iphone users

y(1) = 50;  % intitial condition

for t=2:timesteps
    y(t) = y(t-1);
    
    if (rand < y(t)/N) % we chose iPhone user
        y(t)=y(t)-1; % phone breaks down             
    end
    
    if (rand < p)   % buy iPhone with prob p
        y(t)=y(t)+1;
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
