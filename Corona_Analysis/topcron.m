%               Topos Cronos Pre-flare

%
% *****************************************************

% (1) Correr el script que carga las imagenes
% >> cargamap
nt=47;
load AA3.mat
% (2) Convertir las matrices A{i}'s en vectores renglon:
for i=1:nt
    GM(i,:)=reshape(AA3{i}',1,d3*d3); %GM es GranMatriz(temporal,spacial^2)
end
%**********************************************************************
%                       (3) SVD en 3-D

[U,S,V]=svd(GM);

%UT=U';
VT=V'; % Modos espaciales. Aqui estan guardados todos los modos espaciales 
% en vectores renglon (el primer vector renglon es la matriz modo1 en xy desdoblada)
MO=cell(d3*d3,1);
%MO es el cell array que guarda los modos espaciales en matrices
for i=1:d3*d3
    MN=VT(i,:);
    MO{i}=vec2mat(MN,d3); % Recupero la matriz de modos que vienen de vectores renglon
end


% (4) Matriz truncada:

%r=input('Da como maximo 5 valores de truncamiento:  ');
r=1:47;
% ************************************************************************
%                 (4)  Matrices truncadas    

% TM es cell-array que guarda las matrices aproximadas a diferentes rangos

MT=cell(length(r),1);

for k=1:length(r)
    
    MT{k,1}=zeros(nt,d3*d3);
    
    for i=1:r(k)
    
         MT{k,1} = MT{k,1} + S(i,i)*U(:,i)*VT(i,:);
             
    end
end


save TCprefl.mat MT MO U S V

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
    axis([1 d3 1 d3])
    title(['k=',num2str(isee(j))])
    subplot(4,4,2*j)
    set(gca,'fontsize',18);
    plot(1:nt,-U(1:nt,isee(j)));
    axis([1 48 -0.5 0.5])
    %xlabel('j');
    title(['k=',num2str(isee(j))])
end

SS3=zeros(nt-1,1);
Sum1=0;
Suma1=0;

for i=1:nt
    SS3(i,1)=S(i,i);
    Sum1=Sum1+S(i,i);
end

for i=1:nt
    Suma1=Suma1+S(i,i);
    PC3(i)=Suma1/Sum1;
end


figure(2)
set(gca,'fontsize',16)
set(gcf, 'Color', [1,1,1]);
plot(1:nt,PC3*100,'-o','linewidth',1.2);
title('Energy Contribution Percentage, No Flare (AR)')
xlabel('rank k');
ylabel('%')

figure(3)
semilogy(1:nt-1,SS3(1:nt-1,1),'-o','linewidth',1.2)
set(gca,'fontsize',16)
set(gcf, 'Color', [1,1,1]);
title('Rank vs. Singular Values, No Flare (AR)');
xlabel('Rank (k)');
ylabel('Singular Values \sigma^i');
%

save PFlare.mat PC3 SS3
% *********************************************************************
% **********************************************************************

%                        FOURIER
rr=1:47;
Z=zeros(length(rr),1);
Z2=zeros(length(rr),1);

for i=1:length(rr)
    uk=fft(abs(U));
    for j=2:length(uk)/2
       Z(i)= Z(i) + ((abs(uk(j,i))^2)*j);
       Z2(i)= Z2(i) + ((abs(uk(j,i))^2));
    end
    Frec(i)=Z(i)/Z2(i);
    Tau(i)=82/Frec(i);  % Escala temporal caracteristica del espectro de F.
end


% 
% %   ********************************************************************
% %                           Otra aprox Fourier

% MO{t} es donde se guardan los modos espaciales "doblados" v(x,y)
% Tomamos directamente Fourier de MO{t}(x,y)
% Fourier en 2D. Luego se calcula <kx> y <ky>

fvk=cell(length(rr),1);

for i=1:length(rr)
    fvk{i}=fft2(abs(MO{i}));
end

Sum1=zeros(length(rr),1);
Sum2=zeros(length(rr),1);

for i=1:length(rr)
    for k=2:length(fvk{1})/2
        for j=2:length(fvk{1})/2
            Sum1(i)= Sum1(i) + (abs(fvk{i}(j,k))^2)*(sqrt((j-1)*(j-1)+ ...
                (k-1)*(k-1)));
            Sum2(i) = Sum2(i) + (abs(fvk{i}(j,k))^2);
        end
    end
    KX(i)=Sum1(i)/Sum2(i);
    Lamx(i)=31/KX(i);  % Escala de longitud caracteristica del espectro de F.
end

E=[Tau',Lamx'];


figure (4)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
%loglog(E(:,1),E(:,2),'o'); % Loglog plot of the scale length vs. time scale of the POD components
E1=log(E(2:nt,1));
E2=log(E(2:nt,2));
plot(E1,E2,'o','linewidth',1.2);
xlabel('log(\tau)')
ylabel('log(\lambda)')
title('Pre-flare')
%title('Fourier Analysis: Length scale vs. Time scale. Pre-Flare')
axis manual


% hold on 
% figure (5)
% set(gca,'fontsize',16);
% %loglog(E(2:82,1),E(2:82,2),'o'); 
% EE1=log(E(2:82,1));
% EE2=log(E(2:82,2));
% plot(EE1,EE2,'o');
% xlabel('log(\tau)')
% ylabel('log(\lambda)')
% title('Length scale (\lambda) vs. Time scale (\tau) with out first mode')
% axis manual
% hold off

