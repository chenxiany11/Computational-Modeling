function [u,y] = CouetteNewtonianFluid(U,h,mu)
%mu: fluid's viscosity
%U: speed of the upper plate
%h: height
[y,u] = ode45(@calcDer, [0 h], [0], [], U*mu/h, mu); 
plot(u,y) 
ylabel('height (y)', 'fontsize', 24)
xlabel('velocity (u)', 'fontsize', 24)
title(" Couette flow model for Glycerin at 20°C");
%assume c = U?/h. 
%calculate du/dy
function uPrime = calcDer(y,u,c, mu) 
uPrime = c/mu;
