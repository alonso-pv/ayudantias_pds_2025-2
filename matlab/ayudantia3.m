%% 2.(c)
c = @(k) 1/4*( 1 + (1-sqrt(2)/2)*(exp(-1j*pi*k/2) + exp(-3j*pi*k/2)) );

c(0:3)

c = @(k) 1/4*( 1 + (2-sqrt(2))*cos(pi/2*k) );


c(0:3)
%% 3.(b)
mag  = @(w) 2./sqrt(1.25-cos(w))
fase = @(w) -atan(0.5*sin(w)/(1-0.5*cos(w)))

mag(pi/4)
fase(pi/4)

%% 3.(c)
H = @(om) 2./(1-0.5.*exp(-1j.*om));

h = H(pi/2* (0:3))

ck = c(0:3).*h
abs(h)
angle(h)
%%
mag0 = mag(0)
fase0 = fase(0)

mag1 = mag(pi/2)
fase1 = fase(pi/2)

mag2 = mag(pi)
fase2 = fase(pi)

mag3 = mag(3*pi/2)
fase3 = fase(3*pi/2)