

N = 100;
T = 100000;

PX = 0.7;
PY = 1-PX;

% Phone ownership: iPhone = 1, other = 0
phones = randi(2, [1,N]) - 1;
dist = zeros(1,T);
dist(1) = sum(phones);

for i=2:T
    
    index = randi(N);
    rn = rand();
    
    if (rn < PX)
        phones(index) = 1;
    else
        phones(index) = 0;
    end
    
    dist(i) = sum(phones);
end

f1 = figure(1);
x = linspace(1,T,T);
plot(x, dist./N)




