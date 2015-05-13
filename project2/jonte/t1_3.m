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

% Fit a power law to the data
x_min = 6;
x_all = 1:length(Q_mean);
x = x_min:length(Q_mean);
Q_mean = Q_mean(x);

alpha = 1 + sum(Q_mean)/sum(Q_mean.*log(x./(x_min-0.5)));
C = mean(Q_mean./x.^(-alpha));
y = C * x_all.^(-alpha);
std_alpha = (alpha-1)/sqrt()

hold on 
plot(x_all,y)
s = ['{-' num2str(alpha) '}'];
legend('Simulation data' , ['Power law: ' num2str(C) '*' 'x^' s])

figure(2)
loglog(cumQ_mean);
xlabel('Cluster size x')
ylabel('Number of clusers of size >= x')
