function [RWs]=Gerak_Acak(D,max_iter,lb,ub,cAL,iter)
Xs=zeros(max_iter+1,D);
if rand<0.5
    lb=lb+cAL;
    %ub=-ub+cAL;
else
    lb=-lb+cAL;
    %ub=ub+cAL;
end
if rand>=0.5
    ub=ub+cAL;
else
    ub=-ub+cAL;
end
for j=1:D
    X=[0 cumsum(2*(rand(max_iter,1)>0.5)-1)'];
    X_norm=((X-min(X)).*(ub(j)-lb(j)))./(max(X)-min(X))+lb(j);
    Xs(:,j)=X_norm;
end
RWs=Xs(iter,:).';
