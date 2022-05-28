%Input Knapsack Problem
D=input('Jumlah benda: ');
if D<=0||mod(D,1)~=0
    error('Jumlah benda harus bilangan integer positif!');
end

P=zeros(1,D);
for j=1:D
    fprintf('Keuntungan benda ke-%d:',j);
    P(1,j)=input('');
    if P(1,j)<0
        error('Keuntungan benda harus bilangan riil minimal 0!');
    end
end

W=zeros(1,D);
for j=1:D
    fprintf('Berat benda ke-%d:',j);
    W(1,j)=input('');
    if W(1,j)<=0
        error('Berat benda harus bilangan riil positif!');
    end
end

C=input('Kapasitas knapsack: ');
if C<=0
    error('Kapasitas knapsack harus bilangan riil positif!');
end

%Input ALO
max_iter=input('Jumlah iterasi maksimum: ');
if max_iter<=0||mod(max_iter,1)~=0
    error('Jumlah iterasi maksimum harus bilangan integer positif!');
end

N=input('Jumlah populasi semut dan antlion: ');
if N<=0||mod(N,1)~=0
    error('Jumlah populasi semut dan antlion harus bilangan integer positif!');
end

lb=input('Batas bawah (c): ');
ub=input('Batas atas (d): ');

Ant=zeros(D,N);         %matriks posisi semut
AL=zeros(D,N);          %matriks posisi antlion
Ant_F=zeros(1,N);       %matriks fitness semut
AL_F=zeros(1,N);        %matriks fitness antlion
Ant_W=zeros(1,N);       %matriks berat semut
AL_W=zeros(1,N);        %matriks berat antlion
sorted_AL=zeros(D,N);   %matriks posisi antlion yang sudah diurutkan
bestscore=0;            %nilai solusi terbaik
bestpos=0;              %matriks posisi bestscore
bestiter=0;             %iterasi saat mendapatkan bestscore
bestw=0;                %berat dari bestscore

%Algoritma Perhitungan Rasio dan Pembuatan Matriks Probabilitas Benda
R=zeros(1,D);
Prob=zeros(1,D);
for j=1:D
    R(1,j)=P(1,j)/W(1,j);
    Prob(1,j)=rand;
end

%Algoritma Pembuatan Matriks Posisi dan Perhitungan Fitness
for i=1:N
    %Algoritma Inisialisasi Posisi
    [Ant(:,i),Ant_F(1,i),Ant_W(1,i)]=Inisialisasi_Posisi(D,C,Prob,W,P,R);
    %Algoritma Inisialisasi Posisi
    [AL(:,i),AL_F(1,i),AL_W(1,i)]=Inisialisasi_Posisi(D,C,Prob,W,P,R);
end    
[sorted_AL_F,sorted_index]=sort(AL_F,'descend');
for newindex=1:N
    sorted_AL(:,newindex)=AL(:,sorted_index(newindex));
end
Elite_AL_F=sorted_AL_F(1,1);
Elite_AL=sorted_AL(:,1);

iter=1;
while iter<max_iter+1
    for i=1:N
        %Algoritma Pemilihan Antlion dengan Roda Roulette
        RI=-1;
        accu=cumsum(sorted_AL_F);
        p=rand*accu(end);
        for index=1:length(accu)
            if (accu(index)>p)
            RI=index;
            break;
            end
        end
        if RI==-1
            RI=1;
        end
    
        %Algoritma Pergerakan Semut
        if iter<=0.1*max_iter
            I=1;
        else
            if iter>0.1*max_iter && iter<=0.5*max_iter
                K=2;
            end
            if iter>0.5*max_iter && iter<=0.75*max_iter
                K=3;
            end
            if iter>0.75*max_iter && iter<=0.9*max_iter
                K=4;
            end
            if iter>0.9*max_iter && iter<=0.95*max_iter
                K=5;
            end
            if iter>0.95*max_iter
                K=6;
            end
            I=(iter/max_iter)*10^K;
        end
        lb=lb/I;
        ub=ub/I;
        
        %Algoritma Gerak Acak Terhadap Antlion
        X1=Gerak_Acak(D,max_iter,lb,ub,sorted_AL(:,RI),iter);
        X2=Gerak_Acak(D,max_iter,lb,ub,sorted_AL(:,1),iter);
        
        %Algoritma Fungsi Transfer
        RW1=Fungsi_Transfer(D,X1);
        RW2=Fungsi_Transfer(D,X2);
        
        %Algoritma Crossover
        for j=1:D
            if rand<0.5
                Ant(j,i)=RW1(j,1);
            else
                Ant(j,i)=RW2(j,1);
            end
        end
        Ant_W(1,i)=W*Ant(:,i);
        Ant_F(1,i)=P*Ant(:,i);
        if Ant_W(1,i)>C
            %Algoritma Perbaikan Solusi
            [Ant(:,i),Ant_F(1,i),Ant_W(1,i)]=Perbaikan_Solusi(D,C,W,P,R,Ant(:,i),Ant_F(1,i),Ant_W(1,i));
        end
    end
    %Algoritma Pembaruan Matriks Posisi dan Perhitungan Fitness
    mixPos=[sorted_AL Ant];
    mixF=[sorted_AL_F Ant_F];
    [sorted_mixF,mixIndex]=sort(mixF,'descend');
    sorted_mixPos=mixPos(:,mixIndex);
    
    sorted_AL_F=sorted_mixF(1:N);
    sorted_AL=sorted_mixPos(:,1:N);
    
    if sorted_AL_F(1,1)>Elite_AL_F
        Elite_AL_F=sorted_AL_F(1,1);
        Elite_AL=sorted_AL(:,1);
        bestiter=iter;
    end
    
    bestscore=Elite_AL_F;
    bestw=W*Elite_AL;
    bestpos=Elite_AL;
    
    fprintf('Pada iterasi ke-%d diperoleh best score %d ',iter,bestscore);
    fprintf('dengan berat %d\n',bestw);
    
    iter=iter+1;
end

fprintf('Best score %d diperoleh pada iterasi ke-%d ',bestscore,bestiter);
fprintf('dengan berat %d dan dengan posisi \n',bestw);
bestpos