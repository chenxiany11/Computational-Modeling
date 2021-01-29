function graphU2(h,Time)
gamma = 9220;
theta = [0.0872:0.02:0.1745];

for i = 1:length(theta) 
    for timeIndx = 1:length(Time) 
        [y1,u1] = ode45(@calcDer, [0 h], 0, [], Time(timeIndx)); 
        figure(1); 
        hold on; 
        plot(u1,y1)  
        ylabel('height (y)', 'fontsize', 24); 
        xlabel('velocity (u)', 'fontsize', 24);
 
       
    end
end
function uPrime = calcDer(y, u, t) 
uPrime = gamma*sin(t)*(h-y)*(u+1)*exp(t);
end
end