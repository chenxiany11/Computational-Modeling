function graphU1(gamma, h, theta, mu)

for i = 1:length(theta) 
    t = theta(i);
    [y,u] = ode45(@(u,y) gamma*sin(t)*(h-y)/mu, [0 h], 0); 
    figure(1); 
    hold on
    plot(y,u) 
    ylabel('velocity (u)', 'fontsize', 24)
    xlabel('height (y)', 'fontsize', 24)
    ylim([0 0.05]);
end

end

