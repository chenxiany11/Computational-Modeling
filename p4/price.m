function [sig,r, prices ] = price( P,r)
figure (1)
hold on
xlabel('Days')
ylabel('Price [USD]')
title('Simulated Price')

day = 250;
for i=1:day
    sig = randn(1);
    prices(:,i)=sim(P(end,i),1,1/250,r(i),sig);
    plot(1:day,prices(1:day,i))
end


