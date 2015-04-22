clear all
close all

N = 1000;
T = 100000;

p = 0.5;
qvec = [0:0.01:1];

PX = p;
PY = 1-p;

finalx = zeros(3,length(qvec));
k = 1;
kk = 1;


for start=[0 N/2 N]
    
    for q=qvec

        % Phone ownership: iPhone = 1, other = 0
        xa = zeros(1,length(T));
        xa(1,1) = start;

        for i=2:T
            
            %xa(1,i) = xa(1,i-1) ...
            %    + (N-xa(1,i-1))/N * ( q*PX + (1-q)*xa(1,i-1)/(N-1)*(xa(1,i-1)-1)/(N-2) ) ...
            %    - (xa(1,i-1))/N * ( q*PX + (1-q)*(1 - xa(1,i-1)/(N-1)*(xa(1,i-1)-1)/(N-2)) );
            
            xa(1,i) = xa(1,i-1) ...
                + (N-xa(1,i-1))/N * ( q*PX + (1-q)*xa(1,i-1)/(N-1)*(xa(1,i-1)-1)/(N-2) ) ...
                - (xa(1,i-1))/N * ( q*PX + (1-q)*( (N-xa(1,i-1))/(N-1)*(N-xa(1,i-1)-1)/(N-2)) );
            
        end
        finalx(kk,k) = xa(1,end);
        k = k + 1;
    end
    k = 1;
    kk = kk + 1;
end

f1 = figure(1);
x = 1:length(qvec);
plot(qvec, finalx(1,:)./N, 'b', 'Linewidth', 2)
%ylim([0 1]);
hold on
plot(qvec, finalx(2,:)./N, 'r', 'Linewidth', 2)
plot(qvec, finalx(3,:)./N, 'b', 'Linewidth', 2)

xlabel('q','FontSize', 20)
ylabel('iPhone share','FontSize', 20)
legend('Stable','Instable','Stable')

set(gca, 'FontSize', 16)

pstr = num2str(PX);
pstr = strrep(pstr, '.', ',');
saveas(f1, ['figs/t2p5/MF_N' num2str(N) '_T' num2str(T) '_p' pstr '.eps'], 'epsc')


