function simulation
v1(1) = 100;
v2(1) = 100; % initial money
location = 'C:\Users\chenx11\Desktop\MA342\P4';
data = tabularTextDatastore(location,'FileExtensions','.csv');
table = readall(data);
num_stock=30; % num of stock

for i=1:num_stock 
    P1(:,i)=table((i-1)*251+1:i*251,4);
end

P1=table2array(P1);
%choose first 6 month price
P2=P1((1:125),:);
R=(P2(2:end,:)-P2(1:end-1,:))./P2(1:end-1,:);
r=mean(R);
c=cov(R);
%could change value
alpha=0.419;
%solve qudratic optimazation 1st time
[w(:,1),optVal(1)]=quadprog((1-alpha)*2*c,-alpha*r,[],[],ones(1,num_stock),[1],zeros(num_stock,1),0.2*ones(num_stock,1));

spend(:,1) = (v1(1)*w(:,1))./(P1(125,:)');
Spend2(:,1) = (v2(1)*w(:,1))./(P2(125,:)');
dt=1/125;

%iterate through 6 months
for k=1:6
    for j=1:21
        P2(125+j+21*(k-1),:)=P2(125+j-1+21*(k-1),:)+r.*P2(125+j-1+21*(k-1),:)*dt+r(j)*P2(125+j-1+21*(k-1),:)*sqrt(dt)*randn;
    end
    R=(P2(2+21*(k-1):end,:)-P2(1+21*(k-1):end-1,:))./P2(1+21*(k-1):end-1,:);
    r=mean(R);
    c=cov(R);
    [w(:,k+1),optVal(k+1)]=quadprog((1-alpha)*2*c,-alpha*r,[],[],ones(1,num_stock),[1],zeros(num_stock,1),0.2*ones(num_stock,1));
    v2(k+1)=Spend2(:,k)'*P2(end,:)';
    v1(k+1)=Spend2(:,k)'*P1(125+k*21,:)';
    spend(:,k+1) = (v1(k)*w(:,end))./(P1(125+k*21,:)');
    Spend2(:,k+1) = (v2(k)*w(:,end))./(P2(end,:)');    
end

%compare spend/spend2, v1/v2, 
%show w, optVal


