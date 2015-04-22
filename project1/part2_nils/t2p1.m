clear all
close all

N = 100;
T = 1000;

PX = 0.5;
PY = 1-PX;

% Phone ownership: iPhone = 1, other = 0
phones = randi(2, [1,N]) - 1;
dist = zeros(1,T);
dist(1) = sum(phones);

steps = 1000;
eq_dist = zeros(1,steps);

for j=1:steps
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
    eq_dist(j) = dist(end);
end

asol = zeros(1,N);

for i=1:N
    asol(i) = nchoosek(N,i)*PX^i*(1-PX)^(N-i);
end
asol = asol./sum(asol).*steps;

f1 = figure(1);
hist(eq_dist./N, 100);
hold on
plot(linspace(0,1,N), asol, 'LineWidth', 2, 'Color', 'r');
xlim([0 1]);

xlabel('iPhone share','FontSize', 20)
ylabel('Frequency','FontSize', 20)

legend('Descrete distribution','Master equation')

set(gca, 'FontSize', 16)

pstr = num2str(PX);
pstr = strrep(pstr, '.', ',');

%qstr = num2str(q);
%qstr = strrep(qstr, '.', ',');

%saveas(f1, ['figs/t2p1/N' num2str(N) '_P' pstr '.eps'], 'epsc')
saveas(f1, ['figs/t2p1/comp_N' num2str(N) '_P' pstr '.eps'], 'epsc')


