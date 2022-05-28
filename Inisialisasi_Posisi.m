function[Pos,mF,mW]=Inisialisasi_Posisi(D,C,Prob,W,P,R)
Pos=zeros(D,1);    
for j=1:D
    if rand<=Prob(1,j)
        Pos(j,1)=1;
    else
        Pos(j,1)=0;
    end
end
mW=W*Pos;
mF=P*Pos;

if mW>C
    %Algoritma Perbaikan Solusi
    [Pos,mF,mW]=Perbaikan_Solusi(D,C,W,P,R,Pos,mF,mW);
end

%if mW<C
    %for j=1:D
        %if Pos(j,1)==0 && mW+W(1,j)<=C
            %Pos(j,1)=1;
            %mW=mW+W(1,j);
            %mF=mF+P(1,j);
        %end
    %end
    %[sorted_R,R_index]=sort(R,'descend');
    %for j=1:D
        %if Pos(R_index(j),1)==0 && mW+W(1,j)<=C
            %Pos(R_index(j),1)=1;
            %mW=mW+W(1,R_index(j));
            %mF=mF+P(1,R_index(j));
        %end
    %end
%end