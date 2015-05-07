L = 800;
p = 0.592;

nk = 20;

Q = zeros(nk, L*L);
cumQ = zeros(nk, L*L);

for k=1:nk
   [S, Q_temp] = mean_clustersize(L, p);
   
   Q(k,:) = Q_temp;
   cumQ(k,:) = cumsum(Q_temp, 'reverse');    
end

Q_mean = mean(Q);
cumQ_mean = mean(cumQ);

figure(1)
loglog(Q_mean);
xlabel('Cluster size x')
ylabel('Number of clusers of size x')

x_min = 10;
x=find(Q_mean > x_min);

alpha = 1 + length(x)/(sum(log(Q_mean(x)./(x_min))))
y = Q_mean(x(1)) * x.^(-alpha);
hold on 
plot(x,y)

figure(2)
loglog(cumQ_mean);
xlabel('Cluster size x')
ylabel('Number of clusers of size >= x')
