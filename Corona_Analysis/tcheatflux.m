%              Heat Flux using Topos-Chronos
%

load AAA2.mat
load TCflare.mat

nx=31;
nt=47;
tau=nt*12;
n=1e15;  %densidad
kb=1.38e-23;
L=31*6*715000;
Ct=1.5*n*kb;

for j=1:nt
    PromTopy(j,:)=mean(MO{j}); % promedio en "y" de la temperatura
end

%T=zeros(1,31);
lA=length(U);
% for i=1:lA
%     T(i)=(PromTy(nt,i)-PromTy(1,i))/tau;
% end
for i=1:lA
    PromGradCron(i)=mean(gradient(U(:,i)))*lA/tau;
end
promu=mean(U);
for i=1:nt
    for j=1:nx
        Tx(i,j)=S(i,i)*PromGradCron(i).*PromTopy(i,j);
        Tp(i,j)=S(i,i)*promu(i).*PromTopy(i,j);
    end
end


GT=gradient(Tp);
 
% PT=mean(PromTy); % Promedio de la temperatura en "y" y luego en "t"
 
lT=length(Tx);
 
Sum=zeros(lT);
 
 for i=1:lT
     for j=1:nx
        Sum(i)=Sum(i)+Tx(i,j);
        Qex(i,j)=Ct*Sum(i)*L;
     end       % Vector del flujo de calor en funcion de x
 end
 
 % Flujo de Calor y Velocidad


 for i=1:lT
     for j=1:nx
        Qex(i,j)=Qex(i,nx)-Qex(i,j);
        Vel(i,j)=Qex(i,j)./(n*kb*Tp(i,j)); 
     end
 end
 
 save Veltopc.mat Vel
% 
figure(1)

plot(1:nx,Qex(1,:),'-o',1:nx,Qex(2,:),'-o',1:nx,Qex(3,:),'-o',1:nx,...
    Qex(4,:),'-o','linewidth',1.2)
axis([0 32 -1e4 3e4])
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
%title('Heat Flux as a function of x; Q=Q(x)')
xlabel('x')
ylabel('Q(x) [kg s^{-3}]')
legend('k=1', 'k=2', 'k=3', 'k=4')

% 
% 
figure(2)
plot(1:nx,GT(1,:),'-o','linewidth',1.2)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
%title('Negative gradient averaged in "y" as a function of "x"')
xlabel('x')
ylabel('<-Grad(T)>_{y} [K m^{-1}]')
legend('k=1')


figure(3)
plot(1:nx,GT(2,:),'-o',1:nx,GT(3,:),'-o',1:nx,...
    GT(4,:),'-o','linewidth',1.2)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
%title('Negative gradient averaged in "y" as a function of "x"')
xlabel('x')
ylabel('<-Grad(T)>_{y} [K m^{-1}]')
legend('k=2', 'k=3', 'k=4')


figure(4)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
plot(1:31,6e-3*Tp(1,:),'-o',1:nx,GT(1,:).*(1e-1),'-o',1:31,Qex(1,:),'-o', ...
    'linewidth',1.2)
axis([0 32 -2e4 3e4])
legend('<T(x)>_{t,y} [K]','(-<Grad(T)>_{y})*10^{-1} [K m^{-1}]; (k=1)',' Q(x) [kg s^{-3}]')
%title('Averaged Temperature, Temperature Gradient and Heat Flux as function of x, for k=1')
xlabel('x')

figure(5)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
plot(1:nx,Vel(1,:),'-o','linewidth',1.2)
axis([0 32 0 8e5])
%plot(1:nx,Vel(1,:),'-o',1:nx,Vel(2,:),'-o',1:nx,Vel(3,:),'-o',1:nx,...
  %  Vel(4,:),'-o',1:nx,Vel(5,:),'-o','linewidth',1.2)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
ylabel('v [m/s]')
xlabel('x')
%title('Velocity for k=1')
%legend('Modo 1', 'Modo 2', 'Modo3', 'Modo4','Modo 5')
%legend('k=1')
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Other fits
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This plot shows that there is a section of the spatial domain 
% where the diffusivity would be negative since the flux is positive 
% but the negative of the gradient is negative!
%
figure(6)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
plot(1:nx,10*Qex(1,:),'-o',1:nx,-GT(1,:),'-o', 'linewidth',1.2) 
%title('Heat Flux ans Negative Temperature Gradient as function of x for k=1')
legend('Q(x) [kg s^{-3}]','-Grad(T) [K m^{-1}]')
hold on
plot(0*Qex(1,:),'k','linewidth',1.2)
xlabel('x');
%title('Blue=10* flux and Red=-Grad T')

hold off
%
% These plots show different velocity profiles V=V(x) 
% assuming different levels of *constant* background 
% diffusion
%
figure(7)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
D0=0.0;     % This is free parameter to explore different fittings
plot((Qex(1,:)+D0*n*kb.*GT(1,:))./(n*kb.*Tp(1,:)),'b-o', 'linewidth',1.2); hold  on
axis([0 32 -2e6 2e6])
D0=0.01*10^8;     % This is free parameter to explore different fittings
plot((Qex(1,:)+D0*n*kb.*GT(1,:))./(n*kb.*Tp(1,:)),'r-o', 'linewidth',1.2); hold  on
axis([0 32 -2e6 2e6])
D0=0.1*10^8;     % This is free parameter to explore different fittings
plot((Qex(1,:)+D0*n*kb.*GT(1,:))./(n*kb.*Tp(1,:)),'g-o', 'linewidth',1.2); hold  on
axis([0 32 -2e6 2e6])
D0=0.5*10^8;     % This is free parameter to explore different fittings
plot((Qex(1,:)+D0*n*kb.*GT(1,:))./(n*kb.*Tp(1,:)),'m-o', 'linewidth',1.2); hold  on
axis([0 32 -2e6 2e6])
plot(0*Qex(1,:),'k','linewidth',1.2)
axis([0 32 -2e6 2e6])
xlabel('x'); ylabel('V(x) [m/s]')
%title('Velocity profiles V=V(x) for different levels of constant diffusion, for k=1')
%title('Blue=D0=0, Red=D0=0.01, Green=D0=0.1, Magenta=D0=0.5')
legend('D0=0', 'D0=0.01e8', 'D0=0.1e8', 'D0=0.5e8')
%
% These plots show different diffusivity profiles D=D(x) 
% assuming different levels of *constant* background 
% Advection V. In general it is observed that there are 
% always regions of negative diffusivity!
%
figure(8)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
V0=0.0;     % This is free parameter to explore different fittings
plot((V0*n*kb.*Tp(1,:)-Qex(1,:))./(n*kb.*GT(1,:)),'b-o', 'linewidth',1.2); hold  on
axis([0 32 -2e8 3e8])
V0=2*10^5;     % This is free parameter to explore different fittings
plot((V0*n*kb.*Tp(1,:)-Qex(1,:))./(n*kb.*GT(1,:)),'r-o', 'linewidth',1.2); hold  on
axis([0 32 -2e8 3e8])
V0=4*10^5;     % This is free parameter to explore different fittings
plot((V0*n*kb.*Tp(1,:)-Qex(1,:))./(n*kb.*GT(1,:)),'g-o', 'linewidth',1.2); hold  on
axis([0 32 -2e8 3e8])
V0=8*10^5;     % This is free parameter to explore different fittings
plot((V0*n*kb.*Tp(1,:)-Qex(1,:))./(n*kb.*GT(1,:)),'m-o', 'linewidth',1.2); hold  on
axis([0 32 -2e8 3e8])
plot(0*Qex(1,:),'k','linewidth',1.2)
axis([0 32 -2e8 3e8])
xlabel('x'); ylabel('D(x) [m^{-1}s^{-1}]')
%title('Blue=V0=0, Red=V0=2, Green=V0=4, Magenta=V0=10 * 10^-2')
%title('Diffusivity profiles D=D(x) for different levels of constant velocity, for k=1')
legend('V0=0 m/s','V0=2e5 m/s', 'V0=4e5 m/s', 'V0=8e5 m/s')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Other fits
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This plot shows that there is a section of the spatial domain 
% where the diffusivity would be negative since the flux is positive 
% but the negative of the gradient is negative!
%
figure(9)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
plot(1:nx,10*Qex(2,:),'-o',1:nx,-GT(2,:),'-o', 'linewidth',1.2) 
%title('Heat Flux and Negative Temperature Gradient as function of x for k=2')
legend('Q(x) [kg s^{-3}]','-Grad(T) [K m^{-1}]')
hold on
plot(0*Qex(2,:),'k','linewidth',1.2)
xlabel('x');
%title('Blue=10* flux and Red=-Grad T')

hold off
%
% These plots show different velocity profiles V=V(x) 
% assuming different levels of *constant* background 
% diffusion
%
figure(10)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
D0=0.0;     % This is free parameter to explore different fittings
plot((Qex(2,:)+D0*n*kb.*GT(2,:))./(n*kb.*Tp(2,:)),'b-o', 'linewidth',1.2); hold  on
D0=0.01*10^6;     % This is free parameter to explore different fittings
plot((Qex(2,:)+D0*n*kb.*GT(2,:))./(n*kb.*Tp(2,:)),'r-o', 'linewidth',1.2); hold  on
D0=0.1*10^6;     % This is free parameter to explore different fittings
plot((Qex(2,:)+D0*n*kb.*GT(2,:))./(n*kb.*Tp(2,:)),'g-o', 'linewidth',1.2); hold  on
D0=0.5*10^6;     % This is free parameter to explore different fittings
plot((Qex(2,:)+D0*n*kb.*GT(2,:))./(n*kb.*Tp(2,:)),'m-o', 'linewidth',1.2); hold  on
plot(0*Qex(2,:),'k','linewidth',1.2)
xlabel('x'); ylabel('V(x) [m/s]')
%title('Velocity profiles V=V(x) for different levels of constant diffusion, for k=2')
%title('Blue=D0=0, Red=D0=0.01, Green=D0=0.1, Magenta=D0=0.5')
legend('D0=0', 'D0=0.01e8', 'D0=0.1e8', 'D0=0.5e8')
%
% These plots show different diffusivity profiles D=D(x) 
% assuming different levels of *constant* background 
% Advection V. In general it is observed that there are 
% always regions of negative diffusivity!
%
figure(11)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
V0=0.0;     % This is free parameter to explore different fittings
plot((V0*n*kb.*Tp(2,:)-Qex(2,:))./(n*kb.*GT(2,:)),'b-o', 'linewidth',1.2); hold  on
V0=2*10^4;     % This is free parameter to explore different fittings
plot((V0*n*kb.*Tp(2,:)-Qex(2,:))./(n*kb.*GT(2,:)),'r-o', 'linewidth',1.2); hold  on
V0=4*10^4;     % This is free parameter to explore different fittings
plot((V0*n*kb.*Tp(2,:)-Qex(2,:))./(n*kb.*GT(2,:)),'g-o', 'linewidth',1.2); hold  on
V0=8*10^4;     % This is free parameter to explore different fittings
plot((V0*n*kb.*Tp(2,:)-Qex(2,:))./(n*kb.*GT(2,:)),'m-o', 'linewidth',1.2); hold  on
plot(0*Qex(2,:),'k','linewidth',1.2)
xlabel('x'); ylabel('D(x) [m^{-1}s^{-1}]')
%title('Blue=V0=0, Red=V0=2, Green=V0=4, Magenta=V0=10 * 10^-2')
%title('Diffusivity profiles D=D(x) for different levels of constant velocity, for k=2')
legend('V0=0 m/s','V0=2e5 m/s', 'V0=4e5 m/s', 'V0=8e5 m/s')




%end