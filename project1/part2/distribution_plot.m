N = 15;
p = 0.7;
q = 0.1;

master = @(i) nchoosek(N, i)*p^i*(1-p)^(N-i);

i_vals = 1:N;
y = [];

for i=i_vals
   y = [y master(i)]; 
end

num_exp = 1000;
experiments = zeros(1, num_exp);

for k=1:num_exp
    %experiments(k) = iphone(N, p, 1000); 
    experiments(k) = iphone_3(N,q,10000);
end

figure(1)
hist(experiments)
hold on
%plot(i_vals, y*num_exp, 'r', 'linewidth', 2)
set(gca, 'YTick', [])