%               Topos Chronos 
%                   Active regions and Quiet Sun
% *****************************************************


load AAA2.mat
load PFlare.mat

nt=47;

% (2) Convertir las matrices A{i}'s en vectores renglon:
for i=1:nt
    GM(i,:)=reshape(AA{i}',1,d*d);  %GM es GranMatriz(temporal,spacial^2)
    GM2(i,:)=reshape(AA2{i}',1,d2*d2);
end

%**********************************************************************
%                       (3) SVD en 3-D

[U,S,V]=svd(GM);
[U2,S2,V2]=svd(GM2);

%UT=U';
VT=V'; % Modos espaciales. Aqui estan guardados todos los modos espaciales 
% en vectores renglon (el primer vector renglon es la matriz modo1 en xy desdoblada)

VT2=V2';


MO=cell(d*d,1);
%MO es el cell array que guarda los modos espaciales en matrices
MO2=cell(d2*d2,1);

for i=1:d*d
    MN=VT(i,:);
    MO{i}=vec2mat(MN,d); % Recupero la matriz de modos que vienen de vectores renglon
end
% 
 for i=1:d2*d2
     MN2=VT2(i,:);
     MO2{i}=vec2mat(MN2,d2); % Recupero la matriz de modos que vienen de vectores renglon
 end

 save TCflare.mat U S V MO

% (4) Matriz truncada:

%r=input('Da como maximo 5 valores de truncamiento:  ');

% ************************************************************************
%                 (4)  Matrices truncadas    

% MT es cell-array que guarda las matrices aproximadas a diferentes rangos
r=1:47;
MT=cell(length(r),1);
MT2=cell(length(r),1);


for k=1:length(r)
    
    MT{k,1}=zeros(nt,d*d);
    MT2{k,1}=zeros(nt,d2*d2);
    
    for i=1:r(k)
    
         MT{k,1} = MT{k,1} + S(i,i)*U(:,i)*VT(i,:);
         MT2{k,1} = MT2{k,1} + S2(i,i)*U2(:,i)*VT2(i,:);   
    end
end


save TCflareqs.mat U S V MO U2 S2 V2 MO2 MT MT2

% ***********************************************************************

%             (6)  Graficas de los modos


figure(1)
set(gcf, 'Color', [1,1,1]);
isee=[1 2 3 4 20 30 40 46];
%isee=[40 41 42 43 44 45 46 47];
for j=1:8
    subplot(4,4,2*j-1)
    set(gca,'fontsize',18);
    surf(-S(isee(j),isee(j))*MO{isee(j)}); shading('interp'), view(0,90)
    axis([1 d 1 d])
    title(['k=',num2str(isee(j))])
    subplot(4,4,2*j)
    set(gca,'fontsize',18);
    plot(1:nt,-U(1:nt,isee(j)));
    axis([1 48 -0.5 0.5])
    %xlabel('j');
    title(['k=',num2str(isee(j))])
end

figure(2)
set(gcf, 'Color', [1,1,1]);

for j=1:8
    subplot(4,4,2*j-1)
    set(gca,'fontsize',18);
    surf(-S2(isee(j),isee(j))*MO2{isee(j)}); shading('interp'), view(0,90)
    axis([1 d2 1 d2])
    title(['k=',num2str(isee(j))])
    subplot(4,4,2*j)
    set(gca,'fontsize',18);
    plot(1:nt,-U2(1:nt,isee(j)));
    axis([1 48 -0.5 0.5])
    %xlabel('j');
    title(['k=',num2str(isee(j))])
end

SS=zeros(nt-1,1);
SS2=zeros(nt-1,1);

Sum1=0;
Sum2=0;

Suma1=0;
Suma2=0;


for i=1:nt
    SS(i,1)=S(i,i);
    Sum1=Sum1+S(i,i);
  
    SS2(i,1)=S2(i,i);
    Sum2=Sum2+S2(i,i);
  
end

for i=1:nt
    Suma1=Suma1+S(i,i);
    PC1(i)=Suma1/Sum1;
    
    Suma2=Suma2+S2(i,i);
    PC2(i)=Suma2/Sum2;
  
end

figure(3)
set(gca,'fontsize',20)
set(gcf, 'Color', [1,1,1]);
plot(1:nt,PC1*100,'-o',1:nt,PC3*100,'-o',1:nt,PC2*100,'-o','linewidth',1.2);
%title('Energy Contribution Percentage')
legend('Solar Flare','Pre-Flare','Quiet Sun');
xlabel('Rank r');
ylabel('%')



figure(4)
set(gca,'fontsize',20)
set(gcf, 'Color', [1,1,1]);
semilogy(1:nt,SS(1:nt,1),'-o',1:nt,SS3(1:nt,1),'-o',1:nt,SS2(1:nt,1),'-o','linewidth',1.2)
%title('Singular Values vs. Rank');
legend('Solar Flare','Pre-Flare','Quiet Sun');
xlabel('Rank (k)');
ylabel('Singular Values \sigma^i');



