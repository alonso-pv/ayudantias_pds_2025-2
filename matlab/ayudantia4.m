%% 1 (c) (d)
mag = @(w) 0.2./sqrt(1.64-1.6.*cos(w));
Gdc = mag(0)
Gpi = mag(pi)

wc = fzero( @(w) mag(w)-0.707 , pi/2)

figure
w = linspace(-pi,pi,1000);
plot(w, mag(w));
xlabel('Frequencia (rad/s)');
ylabel('Magnitud');
title('Magnitud |H(ejw)|');
grid on;

%% 1 (e)
mag = @(w) 0.2./sqrt(1.64-1.6.*cos(w));
fase = @(w) -atan2(0.8*sin(w),1-0.8*cos(w));

mag(pi/4)%*5
fase(pi/4)

%% 2 (d)
ceros = exp(2j*pi*(1:4)/5);
figure
plot(real(ceros),imag(ceros),'o',LineWidth=2); hold on;
rectangle('Position', [-1 -1 2 2], 'Curvature', [1 1])
%% 3 (c)
Hlp_ej = @(w) 1./(1-0.9.*exp(-1j.*w));

Hbp_ej = @(w) Hlp_ej(w-pi/3) + Hlp_ej(w+pi/3);
mag = @(w) abs(Hbp_ej(w));

w_max = fminbnd(@(w) -mag(w), 0, pi)
mag_max = mag(w_max)

w = linspace(-pi,pi,1000);
figure
plot(w,mag(w),'LineWidth',2); hold on
plot(w_max, mag(w_max),'o','LineWidth',2)
plot(-w_max, mag(-w_max),'o','LineWidth',2)
xline([-pi/3 pi/3])
xlabel('Frequencia (rad/s)');
ylabel('Magnitud');
title('Magnitud de Hbp');
grid on;