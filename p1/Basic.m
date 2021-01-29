function Basic(x,y,v)
%this code doesn't work quite right....
%v = 76m/s free stream
%density of air kg/m^3
d = 1.225;
[~,np] = size(x);
%find double strength
%backsolve A*mu = b find mu
mu = zeros(1,np);
o = [1 0];
b = zeros(np,1);
for i=1:np
    b(i) = v * dot(n(i), o);
    mu(i) = b(i)\A;
end
%circulation(gamma)
%gamma = -muN
gamma = mu(end)-mu(1);
%lift
%L=-mui*norm(dtf)*d
L = gamma * v * d;
end

