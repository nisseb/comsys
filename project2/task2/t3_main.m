

iter = 100;
timesteps = 500;
pdata1 = zeros(iter,timesteps+1);
adata1 = zeros(iter,timesteps+1);
pdata2 = zeros(iter,timesteps+1);
adata2 = zeros(iter,timesteps+1);

a = pi/2;
a_col = pi/2;
e = 0.5;

for i=1:100
    
    [~, ~, pdata1(i,:), adata1(i,:)] = spp_t3(timesteps, a, a_col, e, 0, 0);
    [~, ~, pdata2(i,:), adata2(i,:)] = spp_t3(timesteps, a, a_col, e, 0, 1);
    i
end
pmean1 = mean(pdata1);
amean1 = mean(adata1);
pmean2 = mean(pdata2);
amean2 = mean(adata2);

figure(1)
plot(1:timesteps+1, pmean1, 'DisplayName', 'Regular')
hold on
plot(1:timesteps+1, pmean2, 'DisplayName', 'Prevent colission')
xlabel('Time', 'FontSize', 20)
ylabel('Polar alignment', 'FontSize', 20)

figure(2)
plot(1:timesteps+1, amean1, 'DisplayName', 'Regular')
hold on
plot(1:timesteps+1, amean2, 'DisplayName', 'Prevent colission')
xlabel('Time', 'FontSize', 20)
ylabel('Apolar alignment', 'FontSize', 20)




