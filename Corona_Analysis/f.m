function FF2=f(mu)
global HH2
%HH2=1.24;
I=(1./mu).*gamma(1./mu);
J=(1./mu).*gamma(3./mu);
F2=(0.5.*mu)./gamma(1./mu).*sqrt(J./I);
FF2=F2/HH2-1;
end