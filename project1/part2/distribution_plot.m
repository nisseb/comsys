N = 100;
p = 0.5;

master = @(i) nchoosek(N, i)*p^i*(1-p)^(N-i);

i_vals = linspace(1,N);
y = [];

for i=i_vals
   y = [y master(i)]; 
end

num_exp = 10000;
experiments = zeros(1, num_exp);

for k=1:num_exp
    experiments(k) = iphone(N, p, 100);    
end

figure(1)
hist(experiments,100)
hold on
plot(i_vals, y*num_exp, 'r', 'linewidth', 2)