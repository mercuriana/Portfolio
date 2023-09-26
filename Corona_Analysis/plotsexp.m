% Fits to averaged PDFs using normalized stretched exponentials
% Fit is based on fixing central value P0 and adjusting exponent mu

load P3.mat   % PX3 y PN3 (Pre-flare)
 load P2.mat   % PX, PN (Flare) PX2 y PN2 (QS)

% Fits to 10% energy
P0=max(PN(3,:))/trapz(PX(3,:),PN(3,:));
mu=linspace(0.5,1.45,20);
 x=linspace(-max(abs(PX(3,:))), max(abs(PX(3,:))),101);
 for i=1:20
 sigma(i)=mu(i)/(2*P0)*gamma(3/mu(i))^0.5/gamma(1/mu(i))^1.5;
for j=1:101
 lf(i,j)=log(P0)-(2*P0*gamma(1/mu(i))/mu(i))^mu(i)*abs(x(j))^mu(i);    
 end
 end
 
 figure(1)
 
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);

 plot(x(:),lf(8,:),'k',x(:),lf(10,:),'b',x(:),lf(12,:),'m',x(:),lf(14,:),'g',...
     x(:),lf(16,:),'r',x(:),lf(18,:),'y',PX(3,:),log(PN(3,:)/...
     trapz(PX(3,:),PN(3,:))),'o','linewidth',1.9);

 %axis([-1e-4 1e-4 1e2 6e4]);
 ylabel('\langle\sigma\rangle PDF normalized')
 xlabel('{\delta}T / <\sigma>')
 title('Flare 10% varying \mu')
 %legend('Flare','S. Expo. - Flare: \mu=1.3 ','Pre-flare',...
 %    'S. Expo. - Pre-flare: \mu=0.92 ','Quiet Sun',...
 %    'S. Expo. - Quiet Sun: \mu=1' )
 axis([PX(3,1) PX(3,40) min(log(PN(3,:))) max(log(PN(3,:)))])
 set(gca,'fontsize',12);
  legend(num2str(mu(8)),num2str(mu(10)),num2str(mu(12)),num2str(mu(14)),...
     num2str(mu(16)),num2str(mu(18)))
%hold on
 
P0=max(PN3(3,:))/trapz(PX3(3,:),PN3(3,:));
 xx=linspace(-max(abs(PX3(3,:))), max(abs(PX3(3,:))),101);
 for i=1:20
 sigma3(i)=mu(i)/(2*P0)*gamma(3/mu(i))^0.5/gamma(1/mu(i))^1.5;
for j=1:101
 lf2(i,j)=log(P0)-(2*P0*gamma(1/mu(i))/mu(i))^mu(i)*abs(xx(j))^mu(i);    
 end
 end

figure(2)
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);
 plot(xx(:),lf2(8,:),'k',xx(:),lf2(10,:),'b',xx(:),lf2(12,:),'m',xx(:),lf2(14,:),'g',...
     xx(:),lf2(16,:),'r',xx(:),lf2(18,:),'y',PX3(3,:),log(PN3(3,:)/...
     trapz(PX3(3,:),PN3(3,:))),'o','linewidth',1.9);
 ylabel('\langle\sigma\rangle PDF normalized')
 xlabel('{\delta}T / <\sigma>')
 title('Pre-Flare 10% varying \mu')
axis([PX3(3,1) PX3(3,40) min(log(PN3(3,:))) max(log(PN3(3,:)))])
 set(gca,'fontsize',12);
  legend(num2str(mu(8)),num2str(mu(10)),num2str(mu(12)),num2str(mu(14)),...
     num2str(mu(16)),num2str(mu(18)))

P0=max(PN2(3,:))/trapz(PX2(3,:),PN2(3,:));
 xxx=linspace(-max(abs(PX2(3,:))), max(abs(PX2(3,:))),101);
 for i=1:20
 sigma2(i)=mu(i)/(2*P0)*gamma(3/mu(i))^0.5/gamma(1/mu(i))^1.5;
for j=1:101
 lf3(i,j)=log(P0)-(2*P0*gamma(1/mu(i))/mu(i))^mu(i)*abs(xxx(j))^mu(i);    
 end
 end

figure(3)
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);
 plot(xxx(:),lf3(8,:),'k',xxx(:),lf3(10,:),'b',xxx(:),lf3(12,:),'m',xxx(:),lf3(14,:),'g',...
     xxx(:),lf3(16,:),'r',xxx(:),lf3(18,:),'y',PX2(3,:),log(PN2(3,:)/...
     trapz(PX2(3,:),PN2(3,:))),'o','linewidth',1.9);
 title('Quiet Sun 10% varying \mu')
 ylabel('\langle\sigma\rangle PDF normalized')
 xlabel('{\delta}T / <\sigma>')
axis([PX2(3,1) PX2(3,40) min(log(PN2(3,:))) max(log(PN2(3,:)))])
 set(gca,'fontsize',12);
  legend(num2str(mu(8)),num2str(mu(10)),num2str(mu(12)),num2str(mu(14)),...
     num2str(mu(16)),num2str(mu(18)))

figure(4)
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);
plot(x(:),lf(18,:),'k',PX(3,:),log(PN(3,:)/trapz(PX(3,:),PN(3,:))),'o',...
    xx,lf2(10,:),'r',PX3(3,:),log(PN3(3,:)/trapz(PX3(3,:),PN3(3,:))),'v',...
    xxx,lf3(14,:),'b',PX2(3,:),log(PN2(3,:)/trapz(PX2(3,:),PN2(3,:))),...
    'd','linewidth',1.9);
 title('Energy content 10%')
 ylabel('\langle\sigma\rangle PDF normalized')
 xlabel('{\delta}T / \langle\sigma\rangle')
axis([PX3(3,1) PX3(3,40) min(log(PN3(3,:))) max(log(PN2(3,:)))])
 set(gca,'fontsize',12);
 legend('Fit-Flare: \mu=1.35','Flare',...
     'Fit-Pre-flare: \mu=0.95 ','Pre-flare',...
     'Fit-Quiet Sun: \mu=1.15','Quiet Sun' )

% Fits to 15% energy ---------------

P0=max(PN(2,:))/trapz(PX(2,:),PN(2,:));
mu=linspace(0.5,1.45,20);
 x=linspace(-max(abs(PX(2,:))), max(abs(PX(2,:))),101);
 for i=1:20
 sigma(i)=mu(i)/(2*P0)*gamma(3/mu(i))^0.5/gamma(1/mu(i))^1.5;
for j=1:101
 lf(i,j)=log(P0)-(2*P0*gamma(1/mu(i))/mu(i))^mu(i)*abs(x(j))^mu(i);    
 end
 end
 
 figure(5)
 
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);

 plot(x(:),lf(9,:),'k',x(:),lf(11,:),'b',x(:),lf(13,:),'m',x(:),lf(17,:),'g',...
     x(:),lf(19,:),'r',x(:),lf(20,:),'y',PX(2,:),log(PN(2,:)/...
     trapz(PX(2,:),PN(2,:))),'o','linewidth',1.9);

 %axis([-1e-4 1e-4 1e2 6e4]);
 %legend('k=25','Strech Exp \mu=0.92, \beta=5.5')
 ylabel('\langle\sigma\rangle PDF normalized')
 xlabel('{\delta}T / \langle\sigma\rangle')
 title('Flare 15% varying \mu')
 %legend('Flare','S. Expo. - Flare: \mu=1.3 ','Pre-flare',...
 %    'S. Expo. - Pre-flare: \mu=0.92 ','Quiet Sun',...
 %    'S. Expo. - Quiet Sun: \mu=1' )
 axis([PX(2,1) PX(2,40) min(log(PN(2,:))) max(log(PN(2,:)))])
 set(gca,'fontsize',12);
  legend(num2str(mu(9)),num2str(mu(11)),num2str(mu(13)),num2str(mu(17)),...
     num2str(mu(19)),num2str(mu(20)))
 %hold on
 
P0=max(PN3(2,:))/trapz(PX3(2,:),PN3(2,:));
 xx=linspace(-max(abs(PX3(2,:))), max(abs(PX3(2,:))),101);
 for i=1:20
 sigma3(i)=mu(i)/(2*P0)*gamma(3/mu(i))^0.5/gamma(1/mu(i))^1.5;
for j=1:101
 lf2(i,j)=log(P0)-(2*P0*gamma(1/mu(i))/mu(i))^mu(i)*abs(xx(j))^mu(i);    
 end
 end

figure(6)
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);
 plot(xx(:),lf2(9,:),'k',xx(:),lf2(11,:),'b',xx(:),lf2(13,:),'m',xx(:),lf2(15,:),'g',...
     xx(:),lf2(17,:),'r',xx(:),lf2(19,:),'y',PX3(2,:),log(PN3(2,:)/...
     trapz(PX3(2,:),PN3(2,:))),'o','linewidth',1.9);
 ylabel('\langle\sigma\rangle PDF normalized')
 xlabel('{\delta}T / \langle\sigma\rangle')
 title('Pre-Flare 15% varying \mu')
axis([PX3(2,1) PX3(2,40) min(log(PN3(2,:))) max(log(PN3(2,:)))])
 set(gca,'fontsize',12);
  legend(num2str(mu(9)),num2str(mu(11)),num2str(mu(13)),num2str(mu(15)),...
     num2str(mu(17)),num2str(mu(19)))

P0=max(PN2(2,:))/trapz(PX2(2,:),PN2(2,:));
 xxx=linspace(-max(abs(PX2(2,:))), max(abs(PX2(2,:))),101);
 for i=1:20
 sigma2(i)=mu(i)/(2*P0)*gamma(3/mu(i))^0.5/gamma(1/mu(i))^1.5;
for j=1:101
 lf3(i,j)=log(P0)-(2*P0*gamma(1/mu(i))/mu(i))^mu(i)*abs(xxx(j))^mu(i);    
 end
 end

figure(7)
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);
 plot(xxx(:),lf3(9,:),'k',xxx(:),lf3(11,:),'b',xxx(:),lf3(13,:),'m',xxx(:),lf3(15,:),'g',...
     xxx(:),lf3(17,:),'r',xxx(:),lf3(19,:),'y',PX2(2,:),log(PN2(2,:)/...
     trapz(PX2(2,:),PN2(2,:))),'o','linewidth',1.9);
 title('Quiet Sun 15% varying \mu')
 ylabel('\langle\sigma\rangle PDF normalized')
 xlabel('{\delta}T / \langle\sigma\rangle')
axis([PX2(2,1) PX2(2,40) min(log(PN2(2,:))) max(log(PN2(2,:)))])
 set(gca,'fontsize',12);
  legend(num2str(mu(9)),num2str(mu(11)),num2str(mu(13)),num2str(mu(15)),...
     num2str(mu(17)),num2str(mu(19)))

figure(8)
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);
plot(x(:),lf(19,:),'k',PX(2,:),log(PN(2,:)/trapz(PX(2,:),PN(2,:))),'o',...
    xx,lf2(13,:),'r',PX3(2,:),log(PN3(2,:)/trapz(PX3(2,:),PN3(2,:))),'v',...
    xxx,lf3(15,:),'b',PX2(2,:),log(PN2(2,:)/trapz(PX2(2,:),PN2(2,:))),...
    'd','linewidth',1.9);
 title('Energy content 15%')
 ylabel('\langle \sigma\rangle PDF normalized')
 xlabel('{\delta}T / \langle\sigma\rangle')
axis([PX3(2,1) PX3(2,40) min(log(PN3(2,:))) max(log(PN2(2,:)))])
 set(gca,'fontsize',12);
 legend('Fit-Flare: \mu=1.4','Flare',...
     'Fit-Pre-flare: \mu=1.1 ','Pre-flare',...
     'Fit-Quiet Sun: \mu=1.2','Quiet Sun' )

% Fits to 25% energy ---------------

P0=max(PN(1,:))/trapz(PX(1,:),PN(1,:));
mu=linspace(0.5,1.45,20);
 x=linspace(-max(abs(PX(1,:))), max(abs(PX(1,:))),101);
 for i=1:20
 sigma(i)=mu(i)/(2*P0)*gamma(3/mu(i))^0.5/gamma(1/mu(i))^1.5;
for j=1:101
 lf(i,j)=log(P0)-(2*P0*gamma(1/mu(i))/mu(i))^mu(i)*abs(x(j))^mu(i);    
 end
 end
 
 figure(9)
 
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);

 plot(x(:),lf(9,:),'k',x(:),lf(11,:),'b',x(:),lf(13,:),'m',x(:),lf(15,:),'g',...
     x(:),lf(17,:),'r',x(:),lf(19,:),'y',PX(1,:),log(PN(1,:)/...
     trapz(PX(1,:),PN(1,:))),'o','linewidth',1.9);

 %axis([-1e-4 1e-4 1e2 6e4]);
 %legend('k=25','Strech Exp \mu=0.92, \beta=5.5')
 ylabel('\langle\sigma\rangle PDF normalized')
 xlabel('{\delta}T / \langle\sigma\rangle')
 title('Flare 25% varying \mu')
 %legend('Flare','S. Expo. - Flare: \mu=1.3 ','Pre-flare',...
 %    'S. Expo. - Pre-flare: \mu=0.92 ','Quiet Sun',...
 %    'S. Expo. - Quiet Sun: \mu=1' )
 axis([PX(1,1) PX(1,40) min(log(PN(1,:))) max(log(PN(1,:)))])
 set(gca,'fontsize',12);
  legend(num2str(mu(9)),num2str(mu(11)),num2str(mu(13)),num2str(mu(15)),...
     num2str(mu(17)),num2str(mu(19)))
 %hold on
 
P0=max(PN3(1,:))/trapz(PX3(1,:),PN3(1,:));
 xx=linspace(-max(abs(PX3(1,:))), max(abs(PX3(1,:))),101);
 for i=1:20
 sigma3(i)=mu(i)/(2*P0)*gamma(3/mu(i))^0.5/gamma(1/mu(i))^1.5;
for j=1:101
 lf2(i,j)=log(P0)-(2*P0*gamma(1/mu(i))/mu(i))^mu(i)*abs(xx(j))^mu(i);    
 end
 end

figure(10)
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);
 plot(xx(:),lf2(9,:),'k',xx(:),lf2(11,:),'b',xx(:),lf2(13,:),'m',xx(:),lf2(15,:),'g',...
     xx(:),lf2(17,:),'r',xx(:),lf2(19,:),'y',PX3(1,:),log(PN3(1,:)/...
     trapz(PX3(1,:),PN3(1,:))),'o','linewidth',1.9);
 ylabel('\langle\sigma\rangle PDF normalized')
 xlabel('{\delta}T / \langle\sigma\rangle')
 title('Pre-Flare 25% varying \mu')
axis([PX3(1,1) PX3(1,40) min(log(PN3(1,:))) max(log(PN3(1,:)))])
 set(gca,'fontsize',12);
  legend(num2str(mu(8)),num2str(mu(10)),num2str(mu(12)),num2str(mu(14)),...
     num2str(mu(16)),num2str(mu(18)))

P0=max(PN2(1,:))/trapz(PX2(1,:),PN2(1,:));
 xxx=linspace(-max(abs(PX2(1,:))), max(abs(PX2(1,:))),101);
 for i=1:20
 sigma2(i)=mu(i)/(2*P0)*gamma(3/mu(i))^0.5/gamma(1/mu(i))^1.5;
for j=1:101
 lf3(i,j)=log(P0)-(2*P0*gamma(1/mu(i))/mu(i))^mu(i)*abs(xxx(j))^mu(i);    
 end
 end

figure(11)
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);
 plot(xxx(:),lf3(9,:),'k',xxx(:),lf3(11,:),'b',xxx(:),lf3(13,:),'m',xxx(:),lf3(15,:),'g',...
     xxx(:),lf3(17,:),'r',xxx(:),lf3(19,:),'y',PX2(1,:),log(PN2(1,:)/...
     trapz(PX2(1,:),PN2(1,:))),'o','linewidth',1.9);
 title('Quiet Sun 25% varying \mu')
 ylabel('\langle\sigma\rangle PDF normalized')
 xlabel('{\delta}T / \langle\sigma\rangle')
axis([PX2(1,1) PX2(1,40) min(log(PN2(1,:))) max(log(PN2(1,:)))])
 set(gca,'fontsize',12);
  legend(num2str(mu(8)),num2str(mu(10)),num2str(mu(12)),num2str(mu(14)),...
     num2str(mu(16)),num2str(mu(18)))

figure(12)
 set(gcf, 'Color', [1,1,1]);
 set(gca,'fontsize',18);
plot(x(:),lf(19,:),'k',PX(1,:),log(PN(1,:)/trapz(PX(1,:),PN(1,:))),'o',...
    xx,lf2(8,:),'r',PX3(1,:),log(PN3(1,:)/trapz(PX3(1,:),PN3(1,:))),'v',...
    xxx,lf3(10,:),'b',PX2(1,:),log(PN2(1,:)/trapz(PX2(1,:),PN2(1,:))),...
    'd','linewidth',1.9);
 title('Energy content 25%')
 ylabel('\langle \sigma\rangle PDF normalized')
 xlabel('{\delta}T / \langle\sigma\rangle')
axis([PX3(1,1) PX3(1,40) min(log(PN3(1,:))) max(log(PN2(1,:)))])
 set(gca,'fontsize',12);
 legend('Fit-Flare: \mu=1.4','Flare',...
     'Fit-Pre-flare: \mu=0.85 ','Pre-flare',...
     'Fit-Quiet Sun: \mu=0.95','Quiet Sun' )

