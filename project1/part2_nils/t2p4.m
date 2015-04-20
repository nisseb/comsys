

N = 1000;
T = 1000;

p = 0.5;
qvec = [0:0.002:1];

PX = p;
PY = 1-p;

finaldist = zeros(1,length(qvec));
k = 1;

for q=qvec
    
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
    finaldist(1,k) = dist(1,end);
    k = k + 1;
end

f1 = figure(1);
x = 1:length(qvec);
plot(x, finaldist(1,:)./N)

xlabel('Time','FontSize', 20)
ylabel('iPhone share','FontSize', 20)

set(gca, 'FontSize', 16)

%saveas(f1, ['figs/t2p3_N' num2str(N) '_T' num2str(T) '.eps'], 'epsc')


