%input knapsack problem
D=input('Jumlah benda: ');
if D<=0
    error('Jumlah benda harus bilangan integer positif!');
end

P=zeros(1,D);
for j=1:D
    fprintf('Keuntungan benda ke-%d:',j);
    P(1,j)=input('');
    if P(1,j)<0
        error('Keuntungan benda harus bilangan integer minimal 0!');
    end
end

W=zeros(1,D);
for j=1:D
    fprintf('Berat benda ke-%d:',j);
    W(1,j)=input('');
    if W(1,j)<=0
        error('Berat benda harus bilangan integer positif!');
    end
end

C=input('Kapasitas knapsack: ');
if C<=0
    error('Kapasitas knapsack harus bilangan integer positif!');
end

%input BALO
max_iter=input('Jumlah iterasi maksimum: ');
if max_iter<=0
    error('Jumlah iterasi maksimum harus bilangan integer positif!');
end

N=input('Jumlah populasi semut dan antlion: ');
if N<=0
    error('Jumlah populasi semut dan antlion harus bilangan integer positif!');
end

c=input('Batas bawah (c): ');

d=input('Batas atas (d): ');
