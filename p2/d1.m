L = 2; 
T = 40;
alpha = 0.1;
dt = 0.028;
dx = 0.01;
rho = 1;
PosX = unique([0:dx:L,L]); 
Time = unique([0:dt:T,T]); 
Sol = zeros(length(PosX), length(Time)); 
Sol(:,2) = (exp(-10*(PosX-(L/2)).^2) ... 
    - exp(-10*(L/2).^2))*dt;
r = alpha*dt^2 / dx^2;
indx = 2:length(PosX)-1; 
 a = 0;
b = 10;
kappa = (a+b)/2;
for j = 3:length(Time)

    Sol(indx,j) = 2*Sol(indx,j-1) - ... 
        Sol(indx,j-2) + r*(Sol(indx+1,j-1) - ... 
        2*Sol(indx,j-1) + Sol(indx-1,j-1))-...
        kappa*(dt/dx)*Sol(indx,j-1); 
    if Sol(indx,j)<0
        disp(Sol(indx,j));
        return;
    end
end
[x, timeframes] = size(Time);
figure(1);
for i = 1:11
    plot(PosX, Sol(:,i)');
    hold on;
end
hold off
title('One dimension');
xlabel('x(position)'); ylabel('u(displacement)');