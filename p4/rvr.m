function [ P,w,optVal,r,C,R ] = rvr(al)

%read read file
%default location
location = 'C:\Users\chenx11\Desktop\MA342\P4';
dd = tabularTextDatastore(location,'FileExtensions','.csv');
alpha=(0:0.01:1).^2;
table = readall(dd);
n=30;

for i=1:n 
    P(:,i)=table((i-1)*251+1:i*251,4);
end

P=table2array(P);
R=(P(2:end,:)-P(1:end-1,:))./P(1:end-1,:);
r=mean(R);
C=cov(R);

for i=1:length(alpha)
    
    [w, optVal] = quadprog((1-alpha(i))*2*C, -alpha(i)*r, [], [], ...
        ones(1,n), [1], zeros(n,1), ones(n,1));
    risk(i) = transpose(w)*C*w;
    exp_return = transpose(r).*w;
    exp1(i) = sum(exp_return);
    
    
    [w2, optVal2] = quadprog((1-alpha(i))*2*C, -alpha(i)*r, [], [], ...
        ones(1,n), [1], zeros(n,1), al*ones(n,1));
    risk2(i) = (w2'*C)*w2;
    exp_return2 = transpose(r).*w2;
    exp2(i) = sum(exp_return2);
    
end

figure (1)
hold on
plot(risk, exp1, '-b','LineWidth', 1)
plot(risk2, exp2,'-r','LineWidth', 1)
xlabel('Risk')
ylabel('Expected Return')