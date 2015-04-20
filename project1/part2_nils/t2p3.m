

N = 100;
T = 30000;

p = 0.5;
q = 0.1;

PX = p;
PY = 1-p;


% Phone ownership: iPhone = 1, other = 0
phones = randi(2, [1,N]) - 1;
dist = zeros(1,T);
dist(1) = sum(phones);

for i=2:T
    
    index = randi(N);
    
    if (rand < q)
        if (rand < PX)
            phones(index) = 1;
        else
            phones(index) = 0;
        end
    else
        
        p = randi(N-1,[1 2]);
        while (p(1) == p(2) || p(1) == index || p(2) == index)
            p = randi(N-1,[1 2]);
        end
        
        if (phones(p(1)) == phones(p(2)))
            phones(index) = phones(1);
        end
        
    end
    
    dist(i) = sum(phones);
end

f1 = figure(1);
x = linspace(1,T,T);
plot(x, dist./N)

xlabel('Time','FontSize', 20)
ylabel('iPhone share','FontSize', 20)

set(gca, 'FontSize', 16)

%saveas(f1, ['figs/t2p3_N' num2str(N) '_T' num2str(T) '.eps'], 'epsc')


