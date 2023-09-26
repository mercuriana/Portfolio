%           Heat Flux - Diego del-Castillo

load AAA2.mat
load Veltopc.mat
nt=47;
tau=nt*12;
n=1e15;  %densidad
kb=1.38e-23;
L=31*6*715000;
Ct=1.5*n*kb;
C2=n*kb;

for j=1:nt
    PromTy(j,:)=mean(AA{j}); % promedio en "y" de la temperatura
end

T=zeros(1,31);
lA=length(AA{1});
% for i=1:lA
%     T(i)=(PromTy(nt,i)-PromTy(1,i))/tau;
% end
for i=1:lA
    T(i)=mean(gradient(PromTy(:,i)))*lA/tau;
end


PT=mean(PromTy); % Promedio de la temperatura en "y" y luego en "t"

Sum=0;
k=1;
for i=1:lA
    Sum=Sum+T(i);
    Qx(i)=Ct*Sum*L; % Vector del flujo de calor en funcion de x                     
end
for i=1:lA
    Qx(i)=Qx(lA)-Qx(i);
end


GT=gradient(PT);

Velo=Qx./(C2*PT); % Velocidad


figure(1)
plot(Qx,'-o', 'linewidth',1.2)
axis([0 32 0 2e4])
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
%title('Heat Flux as a function of x')
xlabel('x')
ylabel('Q(x) [kg s^{-3}]')


figure(2)
plot(-GT,'-o', 'linewidth',1.2)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
%title('Negative Gradient of Temperature averaged in "y" as function of "x"')
ylabel('-<Grad(T)>_y [K/m]')
xlabel('x')

figure(3)
plot(1:31,6e-3*PT,'-o',1:31,-GT.*(1e-1),'-o',1:31,Qx,'-o', 'linewidth',1.2)
axis([0 32 -1e4 2e4])
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
%title('Averaged Temperature, Temperature Gradient and Heat Flux as function of x')
legend('<T(x)>_{t,y} [K]','(-<Grad(T)>_y)*10^{-1} [K/m]','Q(x) [kg s^{-3}]')
xlabel('x')

figure(4)
plot(1:31,Velo,'-o', 'linewidth',1.2)
axis([0 32 0 5e5])
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
%title('Velocity')
%legend('Velocity Original T-maps','Velocity using Top-Chron, k=1')
ylabel('v(x) [m/s]')
xlabel('x')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Other fits
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This plot shows that there is a section of the spatial domain 
% where the diffusivity would negative since the flux is positive 
% but the negative of the gardient is negative!
%
figure(5)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
plot(10*Qx,'b-o', 'linewidth',1.2); hold  on
plot(-GT,'-ro', 'linewidth',1.2)
plot(0*Qx,'k')
xlabel('x'); 
%title('Blue=10* flux and Red=-Grad T')
%
% These plots show different velocity profiles V=V(x) 
% assuming different levels of *constant* background 
% diffuion
%
figure(6)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
D0=0.0;     % This is free parameter to explore different fittings
plot((Qx+D0*C2.*GT)./(C2.*PT),'b-o', 'linewidth',1.2); hold  on
axis([0 32 -4e5 6e5])
D0=0.01e8;     % This is free parameter to explore different fittings
plot((Qx+D0*C2.*GT)./(C2.*PT),'r-o', 'linewidth',1.2); hold  on
axis([0 32 -4e5 6e5])
D0=0.1e8;     % This is free parameter to explore different fittings
plot((Qx+D0*C2.*GT)./(C2.*PT),'g-o', 'linewidth',1.2); hold  on
axis([0 32 -4e5 6e5])
plot(0*Qx,'k','linewidth',1.2)
axis([0 32 -4e5 6e5])
xlabel('x'); ylabel('V(x) [m/s]')
%title('Velocity profiles V=V(x) for different levels of constant diffusion')
legend('D0=0', 'D0=0.01e8', 'D0=0.1e8')
%
% These plots show different diffusivity profiles D=D(x) 
% assuming different levels of *constant* background 
% Advection V. In general it is observed that there are 
% always regions of negative diffusivity!
%
figure(7)
set(gcf, 'Color', [1,1,1]);
set(gca,'fontsize',20);
V0=0.0;     % This is free parameter to explore different fittings
plot((V0*C2.*PT-Qx)./(C2.*GT),'b-o', 'linewidth',1.2); hold  on
axis([0 32 -1.5e8 1.5e8])
V0=2*10^5;     % This is free parameter to explore different fittings
plot((V0*C2*PT-Qx)./(C2.*GT),'r-o', 'linewidth',1.2); hold  on
axis([0 32 -1.5e8 1.5e8])
V0=4*10^5;     % This is free parameter to explore different fittings
plot((V0*C2.*PT-Qx)./(C2.*GT),'g-o', 'linewidth',1.2); hold  on
axis([0 32 -1.5e8 1.5e8])
plot(0*Qx,'k','linewidth',1.2)
axis([0 32 -1.5e8 1.5e8])
xlabel('x'); ylabel('D(x) [m^{-1}s^{-1}]')
%title('Diffusivity profiles D=D(x) for different levels of constant velocity')
legend('V0=0 m/s','V0=2e5 m/s', 'V0=4e5 m/s')




