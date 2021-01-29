%question 2 code
%I pledge this is my code
%initialization
L = 1;
dx = 0.01;
dt = 0.001;
r = dt/dx;
T = unique([0:dt:T,T]); 
xi = (0:0.01:2)';
H = 0:0.01:1;
kappa = zeros(100,100);
j = 1;
t = 0:0.01:40;

for h = 0:0.01:1 
	
    for i = 1:length(T)
		%find best kappa
		a = 0;
		b = 10;
		t = 0;
        while abs(b - a) > 0.001
			mkappa = (b + a) / 2;
			past = zeros(length(xi), 1);
            % require that our approximation satis?es 
			current = past + (exp(-10 * (xi - L / 2).^2) - exp(-10 * (L / 2).^2))*dt;			
			current(1) = 0;
			current(end) = 0;
			new = current;
			
			new(2:end-1) = ((2 - 2 * H(j) * r^2 + mkappa * dt) * current(2:end - 1) + H(j) * r^2 * (current(1:end - 2) +...
                    current(3:end)) - past(2:end - 1)) / (1 + mkappa * dt);
			new(1) = 0;
			new(end) = 0;
            figure(1);
			strtitle = ['Solution at time, t= ', num2str(i), ', where \kappa = ', num2str(mkappa)];
			plot(x, current);
			title(strtitle);
			xlabel('x');
			ylabel('y');
			axis([0, L, 0, 1]);
			past = current;
			current = new;
			t = t + dt;
			disp(current);
            
            if any(new < 0)
                a = mkappa;
				return;
			else
				
				b = mkappa;
            end
        end
		kappa(i, j) = mkappa;		
    end	
	j = j + 1;	
end
