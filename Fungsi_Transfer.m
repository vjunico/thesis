function RW=Fungsi_Transfer(D,X)
RW=zeros(D,1);
Y=sigmf(X,[2,0]);
for j=1:D
    if rand<Y(j,1)
        RW(j,1)=0;
    else
        RW(j,1)=1;
    end
end

