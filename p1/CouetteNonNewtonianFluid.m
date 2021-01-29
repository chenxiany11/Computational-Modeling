function CouetteNonNewtonianFluid(U,h,Time) 
%c = U*mu/h;
c = 150; 
delta = 10^(-8); 
tol = 0.01;


for UIndx = 1:length(U)

    for timeIndx = 1:length(Time) 
        err = inf; 
        while err > tol 
            [y1,u1] = ode45(@calcDer, [0 h], 0, [], c, Time(timeIndx)); 
            [~,u2] = ode45(@calcDer, [0 h], 0, [], c+delta, Time(timeIndx)); 
            U1 = u1(length(u1)); 
            U2 = u2(length(u2)); 
            err = min(err, abs(U(UIndx)-U1)); 
            dudc = (U2-U1)/delta;
            c = c-(U1-U(UIndx))/dudc; 
            r = 1\((u1+1)*exp(Time(timeIndx))); 
           
        end
        figure(1); 
        hold on; 
        plot(u1,y1)  
        ylabel('height (y)', 'fontsize', 24); 
        xlabel('velocity (u)', 'fontsize', 24);
 
       
    end
    figure(2); 
        hold on; 
        plot(y1,r) 
        ylabel('tau(du/dy)', 'fontsize', 24); 
        xlabel('height(y) m', 'fontsize', 24);
end

function uPrime = calcDer(y, u, c, t) 
uPrime = c*(u+1)*exp(t);
