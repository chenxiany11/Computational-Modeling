
k = 0.13;
c = 0.11; 
p = 7.8; 
dx = 0.05;
dt = (0.45)*c*p*dx^2/k; 
EndTime = 10; 
RodLength = 2; 
NumPlots = 10;
PosX = unique([0:dx:RodLength, RodLength]);
Time = unique([0:dt:EndTime, EndTime]);
Sol = zeros( length(PosX), length(Time)); 
Sol(:,1) = 2*PosX + 1;
Sol(1,:) = 1;
Sol(length(PosX),:) = 4*exp(-Time)+1;
r = (k*dt)/(c*p*dx^2); 
indx = 2:length(PosX)-1;
for t=2:length(Time) 
    Sol(indx,t) = (1-2*r)*Sol(indx,t-1) ...
        + r*(Sol(indx-1,t-1) + Sol(indx+1,t-1)); 
end
