N = 1000;
q = 0.3;

timesteps = 100000;

q_vals = 0:0.01:1;
endstate = []

for q=q_vals

    y = zeros(1, timesteps);  % number of iphone users
    y(1) = 250;  % intitial condition

    mean_field = @(x) q/2*(N-x)/N+(N-x)/N*(1-q)*x^2/N^2 ...
                      - q*x/(2*N) - x/N * (1-q)*((N-x)/N)^2;

    for t=2:timesteps
       y(t) = y(t-1) + mean_field(y(t-1));
    end
    
    endstate = [endstate y(end)];

end

plot(q_vals, endstate)