function[Pos,mF,mW]=Perbaikan_Solusi(D,C,W,P,R,Pos,mF,mW)
[sorted_R,R_index]=sort(R);
j=1;
while mW>C&&j~=D
    if Pos(R_index(j),1)==1
        Pos(R_index(j),1)=0;
        mW=mW-W(1,R_index(j));
        mF=mF-P(1,R_index(j));
    end
    j=j+1;
end





jjj=sorted_R;