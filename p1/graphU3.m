function graphU3(h,Time)
gamma = 7850;
theta = [0.0872:0.008:0.1047];

for i = 1:length(theta) 
    for timeIndx = 1:length(Time) 
        [y1,u1] = ode45(@calcDer, [0 h], 0, [],Time(timeIndx)); 
        figure(1); 
        hold on; 
        plot(u1,y1)  
        ylabel('height (y)', 'fontsize', 24); 
        xlabel('velocity (u)', 'fontsize', 24);
 
       
    end
end
function uPrime = calcDer(y, u, t) 
uPrime = gamma*sin(t)*(h-y)*(u/4000 - 15)*40*((t+1)/t);
end
end