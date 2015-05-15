function [pol, apol, pvec, avec] = spp(timesteps, a, a_col, e, makemovie, TASK3)
% Self-propelled particle model of aggregation in two dimensions.
% Written by Kit Yates


%Set up movie
makemovie;
if makemovie
    fig=figure(1);
end
%movien = avifile('Vicsekmovie','FPS',3,'compression','none')

J=timesteps; %Number of timestep t0 be used
UJ=1;   %Rate at which film is updated


t=1/J; %Size of one time step

N=40; %Number of particles

r_int=2;
r_col=0.5;
ang = a;
col_ang = a_col;

L=10; %L is the size of the domain on which the particles can move

vel=0.5; %v is the speed at which the particles move
v = vel;
v = ones(N,1) .* vel;

% x(i,j) gives the x coordinate of the ith particle at time j
x=zeros(N,J+1);
x(:,1)=L*rand(N,1); %define initial x coordiantes of all particles
     
% y(i,j) gives the y coordinate of the ith particle at time j
y=zeros(N,J+1);
y(:,1)=L*rand(N,1); %define initial y coordiantes of all particles

% T(i,j) gives the angle with the x axis of the direction of motion of the ith
% particle at time j
T=zeros(N,J+1);
T(:,1)=2*pi*rand(N,1); %define initial direction of all particles

% phi_p, phi_a gives polar and apolar angle
phi_p = zeros(1,J+1);
phi_a = zeros(1,J+1);
phi_p(1) = 1/N * sum( exp( 1i*T(:,1) ) );
phi_a(1) = 1/N * sum( exp( 2i*T(:,1) ) );

     
%For all time steps
for j=1:J
    %For each particle
    for i=1:N
            %finds how many particles are in the interaction radius of each
            %particle
            A(:,1)=((x(i,j)-x(:,j)).^2+(y(i,j)-y(:,j)).^2).^0.5<=r_int;
            A(:,2)=((x(i,j)-x(:,j)-L).^2+(y(i,j)-y(:,j)).^2).^0.5<=r_int;
            A(:,3)=((x(i,j)-x(:,j)).^2+(y(i,j)-y(:,j)-L).^2).^0.5<=r_int;
            A(:,4)=((x(i,j)-x(:,j)+L).^2+(y(i,j)-y(:,j)).^2).^0.5<=r_int;
            A(:,5)=((x(i,j)-x(:,j)).^2+(y(i,j)-y(:,j)+L).^2).^0.5<=r_int;
            A(:,6)=((x(i,j)-x(:,j)+L).^2+(y(i,j)-y(:,j)+L).^2).^0.5<=r_int;
            A(:,7)=((x(i,j)-x(:,j)+L).^2+(y(i,j)-y(:,j)-L).^2).^0.5<=r_int;
            A(:,8)=((x(i,j)-x(:,j)-L).^2+(y(i,j)-y(:,j)+L).^2).^0.5<=r_int;
            A(:,9)=((x(i,j)-x(:,j)-L).^2+(y(i,j)-y(:,j)-L).^2).^0.5<=r_int;
            
            A2(:,1)=((x(i,j)-x(:,j)).^2+(y(i,j)-y(:,j)).^2).^0.5<=r_col;
            A2(:,2)=((x(i,j)-x(:,j)-L).^2+(y(i,j)-y(:,j)).^2).^0.5<=r_col;
            A2(:,3)=((x(i,j)-x(:,j)).^2+(y(i,j)-y(:,j)-L).^2).^0.5<=r_col;
            A2(:,4)=((x(i,j)-x(:,j)+L).^2+(y(i,j)-y(:,j)).^2).^0.5<=r_col;
            A2(:,5)=((x(i,j)-x(:,j)).^2+(y(i,j)-y(:,j)+L).^2).^0.5<=r_col;
            A2(:,6)=((x(i,j)-x(:,j)+L).^2+(y(i,j)-y(:,j)+L).^2).^0.5<=r_col;
            A2(:,7)=((x(i,j)-x(:,j)+L).^2+(y(i,j)-y(:,j)-L).^2).^0.5<=r_col;
            A2(:,8)=((x(i,j)-x(:,j)-L).^2+(y(i,j)-y(:,j)+L).^2).^0.5<=r_col;
            A2(:,9)=((x(i,j)-x(:,j)-L).^2+(y(i,j)-y(:,j)-L).^2).^0.5<=r_col;
            
        
            B=sum(A')';
            A_col = sum(A2')';
            A_col_ang = A_col .* ( abs((T(i,j) - T(:,j))) >= ang );
            
            %%%%% Task 3 %%%%%
            
            if TASK3
            
                if (sum(A_col) > 1 && sum(A_col_ang) > 1)
                    v(i) = 0.1;
                    ang = 2*pi;
                end

                % Does not follow individuals to close
                B = B .* not(A_col);
                B(i) = 1;
            end
            
            %%%%% End of task 3 %%%%%
            
            % Only interact with individuals with similar T
            B = B .* ( abs((T(i,j) - T(:,j))) <= ang );
            %A_col = A_col .* ( abs((T(i,j) - T(:,j))) <= ang );
            
            ss=sum(sin(T(:,j)).*B)/sum(B);
            sc=sum(cos(T(:,j)).*B)/sum(B);
            S=atan2(ss,sc);
                   
            T(i,j+1)=S+e*(rand-0.5); %adds noise to the measured angle

            x(i,j+1)=x(i,j)+v(i)*cos(T(i,j+1)); %updates the particles' x-coordinates
            y(i,j+1)=y(i,j)+v(i)*sin(T(i,j+1)); %updates the particles' y coordinates

            % Jumps from the right of the box to the left or vice versa
            x(i,j+1)=mod(x(i,j+1),L);

            %Jumps from the top of the box to the bottom or vice versa
            y(i,j+1)=mod(y(i,j+1),L);

            %Plot particles
            
            if makemovie
                if abs(x(i,j)-x(i,j+1))<v(i) & abs(y(i,j)-y(i,j+1))<v(i)
                	plot([x(i,j), x(i,j+1)] ,[y(i,j),y(i,j+1)],'k-','markersize',4) %plots the first half of the particles in black
                    axis([0 L 0 L]);
                    hold on
                    plot(x(i,j+1) ,y(i,j+1),'k.','markersize',10)
                    xlabel('X position')
                    ylabel('Y position')
                end
            end
            
            v(i) = vel;
            ang = a;
            
    end
    if makemovie
        hold off
        M(j)=getframe; %makes a movie fram from the plot
        %movien = addframe(movien,M(j)); %adds this movie fram to the movie
    end
    
    phi_p(j+1) = 1/N * abs(sum( exp( 1i*T(:,j+1) ) ));
    phi_a(j+1) = 1/N * abs(sum( exp( 2i*T(:,j+1) ) ));
 
end

pol = phi_p(end);
apol = phi_a(end);

pvec = phi_p;
avec = phi_a;

if ~makemovie
    f2 = figure(2);
    plot(1:J+1, phi_p, 'LineWidth', 1, ...
         'DisplayName', ['alpha = ' num2str(a)])
    

    lh2 = legend('-DynamicLegend');
    xlabel('time t', 'FontSize', 20)
    ylabel('Polar order', 'FontSize', 20)
    set(lh2, 'FontSize', 16, 'Location', 'best')
    set(gca, 'FontSize', 16)

    f3 = figure(3);
    plot(1:J+1, phi_a, 'LineWidth', 1, ...
         'DisplayName', ['alpha = ' num2str(a)])
    

    lh3 = legend('-DynamicLegend');
    xlabel('time t', 'FontSize', 20)
    ylabel('Apolar order', 'FontSize', 20)
    set(lh3, 'FontSize', 16, 'Location', 'best')
    set(gca, 'FontSize', 16)
end


%movien = close(movien); %finishes the movie
end
