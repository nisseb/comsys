q_vals = 0:0.001:1;
y = zeros(size(q_vals));
N = 15;

for k=1:length(q_vals)
    y(k) = iphone_3(N, q_vals(k), 100000);
end

plot(q_vals, y, '*')
xlabel('q')
ylabel('iPhone users at equilibrium')