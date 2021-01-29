function [P] = sim( P0, t,dt, mu, sig )

P = zeros(round(t/dt)+1,1);
P(1) = P0;

for ind = 2:length(P)
    P(ind) = P(ind-1)+mu*P(ind-1)*dt+sig*P(ind-1)*sqrt(dt)*randn(1);
end
end
