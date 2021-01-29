%question 3,4 code
%I pledge this is my code
L = 1;
T = 10;
H = 0.1;
rho = 1;
dx = 0.01;
dy = 0.01;
dt = 0.85 *sqrt(rho/H)*dx;
PosX = unique([-L:dx:L,L]);
PosY = unique([-L:dy:L,L]);
Time = unique([0:dt:T,T]);

u = zeros(length(PosX), length(PosY), length(Time));

for k = 2: length(PosY)
 %  u(:,k,2) = (PosX.^2 + PosY.^2)/10;
 %    u(:,k,2) = (PosX + PosY)/10;
    u(:,k,2) = (PosX.^3 + PosY.^3)/10;
 %    u(:,k,2) = max(abs(PosX), abs(PosY))/10;
end
r1 = H/rho * dt^2/dx^2;
r2 =  H/rho * dt^2/dy^2;

xx = 2:length(PosX)-1;
yy = 2:length(PosY)-1;

for i = 3: length(Time) 
    u(xx, yy, i) = 2*u(xx, yy, i-1) - u(xx, yy, i-2) + ...
        r1*(u(xx+1, yy, i-1) - 2*u(xx, yy, i-1) + ...
        u(xx-1, yy, i-1)) + r2*(u(xx, yy+1, i-1) - ...
        2*u(xx, yy, i-1) + u(xx, yy-1, i-1));
    for px = xx
        for py = yy
            a = PosX(px);
            b = PosY(py);
  %          if (abs(a^2 + b^2-1)<=0.001)
 %           if (abs(a + b-1)<=0.001)
           if (abs(a^3 + b^3 -1) <=0.001)
 %            if (max(abs(a),abs(b))==1)
                u(px, py, :) = 0.1;
            end
            %radius larger then 1 is invalid
            if ((a^2 + b^2) > 1)
                u(px, py, :) = nan;
            end
        end
    end
end
%plot the graph
[x, timeframes] = size(Time);
figure(1);
for i = 1:5
    h = surf(PosX, PosY, u(:,:,i)');
    set(h, 'LineStyle', 'none');
    hold on;
end
hold off
title('Wave equation over the unit disc when p = \infty');
xlabel('x');
ylabel('y'); 
zlabel('u(displacement)');