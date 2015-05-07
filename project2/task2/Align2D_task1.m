% Self-propelled particle model of aggregation in two dimensions.
% Written by Kit Yates

clear
close all



%Set up movie
fig=figure;
makemovie=0;
%movien = avifile('Vicsekmovie','FPS',3,'compression','none')

J=500; %Number of timestep t0 be used
UJ=1;   %Rate at which film is updated


t=1/J; %Size of one time step

N=40; %Number of particles

e=0.5; %e is eta the noise parameter, whose maximum value is 2*pi

r=1;

%The radius of influence of a particle

L=10; %L is the size of the domain on which the particles can move

v=0.5; %v is the speed at which the particles move

a = [0 pi/3 2*pi/3];
a = a(3);

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
            A(:,1)=((x(i,j)-x(:,j)).^2+(y(i,j)-y(:,j)).^2).^0.5<=r;
            A(:,2)=((x(i,j)-x(:,j)-L).^2+(y(i,j)-y(:,j)).^2).^0.5<=r;
            A(:,3)=((x(i,j)-x(:,j)).^2+(y(i,j)-y(:,j)-L).^2).^0.5<=r;
            A(:,4)=((x(i,j)-x(:,j)+L).^2+(y(i,j)-y(:,j)).^2).^0.5<=r;
            A(:,5)=((x(i,j)-x(:,j)).^2+(y(i,j)-y(:,j)+L).^2).^0.5<=r;
            A(:,6)=((x(i,j)-x(:,j)+L).^2+(y(i,j)-y(:,j)+L).^2).^0.5<=r;
            A(:,7)=((x(i,j)-x(:,j)+L).^2+(y(i,j)-y(:,j)-L).^2).^0.5<=r;
            A(:,8)=((x(i,j)-x(:,j)-L).^2+(y(i,j)-y(:,j)+L).^2).^0.5<=r;
            A(:,9)=((x(i,j)-x(:,j)-L).^2+(y(i,j)-y(:,j)-L).^2).^0.5<=r;
        
            B=sum(A')';
            
            % Only interact with individuals with similar T
            B = B .* ( abs((T(i,j) - T(:,j))) <= a );
            
            ss=sum(sin(T(:,j)).*B)/sum(B);
            sc=sum(cos(T(:,j)).*B)/sum(B);
            S=atan2(ss,sc);
                   
            T(i,j+1)=S+e*(rand-0.5); %adds noise to the measured angle

            x(i,j+1)=x(i,j)+v*cos(T(i,j+1)); %updates the particles' x-coordinates
            y(i,j+1)=y(i,j)+v*sin(T(i,j+1)); %updates the particles' y coordinates

            % Jumps from the right of the box to the left or vice versa
            x(i,j+1)=mod(x(i,j+1),L);

            %Jumps from the top of the box to the bottom or vice versa
            y(i,j+1)=mod(y(i,j+1),L);

            %Plot particles
            
            if makemovie
                if abs(x(i,j)-x(i,j+1))<v & abs(y(i,j)-y(i,j+1))<v
                	plot([x(i,j), x(i,j+1)] ,[y(i,j),y(i,j+1)],'k-','markersize',4) %plots the first half of the particles in black
                    axis([0 L 0 L]);
                    hold on
                    plot(x(i,j+1) ,y(i,j+1),'k.','markersize',10)
                    xlabel('X position')
                    ylabel('Y position')
                end
            end
            
    end
    if makemovie
        hold off
        M(j)=getframe; %makes a movie fram from the plot
        %movien = addframe(movien,M(j)); %adds this movie fram to the movie
    end
    
    phi_p(j+1) = 1/N * abs(sum( exp( 1i*T(:,j+1) ) ));
    phi_a(j+1) = 1/N * abs(sum( exp( 2i*T(:,j+1) ) ));
 
end

f2 = figure(2);
plot(1:J+1, phi_p)



f3 = figure(3);
plot(1:J+1, phi_a)



     
%movien = close(movien); %finishes the movie

