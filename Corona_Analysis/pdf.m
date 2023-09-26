% Histograms

%                           Histogram PDF    Pre-Flare


% Correr primero "topcron".


load AA3.mat
load TCprefl.mat


t=47; 
k=[2 16 25];
size=d3*d3;

RE=cell(t,length(k));
MR=cell(t,length(k));
MRR=cell(length(k),1);
Y=cell(length(k),1);
X=cell(length(k),1);

YY=cell(length(k),1);
XX=cell(length(k),1);

for j=1:length(k)
    for i=1:t
    RE{i,j}=vec2mat(MT{k(j)}(i,:),d3);
 
    MR{i,j}=AA3{i}-RE{i,j};
    MRR{j}(i,:)=reshape(MR{i,j},[1,size]);

    [Y{j}(i,:) X{j}(i,:)]=hist(MRR{j}(i,:),40);
   
    x2p(j,i)=mean(MRR{j}(i,:).*MRR{j}(i,:));
    xp2(j,i)=mean(MRR{j}(i,:)).^2;
    sd(j,i)=x2p(j,i)-xp2(j,i);
    
    end
end


promsd=mean(sd');
 
mo=100-74.9;
ra=100-85.3;
do=100-90.4;
pk=[mo ra do];
for j=1:length(k)
     
     subplot(2,3,j)
     set(gcf, 'Color', [1,1,1]);
     set(gca,'fontsize',16);
        for i=1:t
        Delta=X{j}(i,2)-X{j}(i,1);
        Area=(trapz(Y{j}(i,:)))*Delta;
        XX{j}(i,:)=X{j}(i,:)./promsd(j);
        YY{j}(i,:)=promsd(j).*Y{j}(i,:)/Area;
        semilogy(XX{j}(i,:),YY{j}(i,:),'-o');
        
        hold on
        end
        
     ylabel('PDF / <\sigma >')
     xlabel('T_f / <\sigma >  ')
        title(['Pre-flare, k=',num2str(k(j)),'  Energy contrib. %',num2str(pk(j))]);
        hold off
   
  %    Promedios
    for ii=1:40
        PX3(j,ii)=mean(XX{j}(:,ii));
        PN3(j,ii)=mean(YY{j}(:,ii));
    end
     subplot(2,3,j+3)
     set(gcf, 'Color', [1,1,1]);
     set(gca,'fontsize',18);
     semilogy(PX3(j,:),PN3(j,:)/trapz(PX3(j,:),PN3(j,:)),'-o','linewidth',1.2);
     axis([-1e6 1e6 9e-9 8e-6]);
     title('Mean')
     ylabel('PDF / <\sigma >')
     xlabel('T_f / <\sigma >  ')
     mix=min(PX3(j,:));
     miy=min(PN3(j,:)/trapz(PX3(j,:),PN3(j,:)));
     mas=max(PX3(j,:));
     may=max(PN3(j,:)/trapz(PX3(j,:),PN3(j,:)));
     axis([mix mas miy may])
end
 
save P3.mat PX3 PN3
% 
