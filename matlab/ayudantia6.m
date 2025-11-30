%% 3 Aproximación de TDTC mediante TFD
% Expresión analítica
X_tftc = @(Om) 100*pi./( (1j*Om+10).^2 + 400*pi^2 );

% Señal continua
xc = @(t) 5.*exp(-10*t).*sin(20*pi*t);

% Parámetros para el muestreo
Fs = 200;
T = 1/Fs;
N = 400;
n = 0:N-1;

X_tfd = fft(xc(n*T));

X_approx = T * fftshift(X_tfd);

% Muestreo de la frecuencia
k = -N/2:N/2-1;
Om_approx = 2*pi/(N*T)*k;

Om_cont = linspace(Om_approx(1), Om_approx(end), 2000);

figure;
subplot(2,1,1)
stem(Om_approx, abs(X_approx)); hold on
plot(Om_cont, abs(X_tftc(Om_cont)));
title("Magnitud de X(j\Omega)");
subplot(2,1,2)
stem(Om_approx, angle(X_approx)); hold on
plot(Om_cont, angle(X_tftc(Om_cont)));
title("Fase de X(j\Omega)");

%% 4 Aproximación de coeificientes de fourier mediante TFD
% Expresión analítica
c = @(k) (1-exp(-5))./(5+2j*pi*k);

% Señal continua
xc = @(t) exp(-t); % 0<t<5
T0 = 5;

% Muestreo
N = 100;
T = T0/N;
n = 0:N-1;

% Approximacion de coeficientes
X_tfd = fft(xc(n*T));
c_approx = fftshift(X_tfd)/N;
k = -N/2:N/2-1;

figure;
subplot(2,1,1)
stem(k, abs(c_approx)); hold on
stem(k, abs(c(k)), "x");
legend("aproximación de c_k", "c_k analítico")
title("Magnitud de c_k")
%xlim([-N/4, N/4])
subplot(2,1,2)
stem(k, angle(c_approx)); hold on
stem(k, angle(c(k)), "x");
legend("aproximación de c_k", "c_k analítico")
title("Fase de c_k");
%xlim([-N/4, N/4])

%% 5 TFTD y TFD comparadas
% Expresión analítica
X_tftd = @(w) ...
    1/2*( 1 - exp(1j*(0.25*pi-w)*100) )./( 1 - exp(1j*(0.25*pi-w)) ) ...
    + 1/2*( 1 - exp(-1j*(0.25*pi+w)*100) )./( 1 - exp(-1j*(0.25*pi+w)) );

% Señal discreta
x = @(n) cos(0.25*pi*n).*(n>=0 & n<=99);

% TFD
N=200;
X_tfd = fft(x(0:N-1)); % aplicar fftshift si se quiere graficar en -pi, pi

% Tolerancia
% Fases erróneas en valores cercanos a cero
tol = 10^-6;
X_tfd(X_tfd<tol) = 0;

w = linspace(0, 2*pi, 1000);

% Muestreo de la frecuencia
k = 0:N-1;
w_discr = 2*pi*k/N;

figure
subplot(2,1,1)
plot(w, abs(X_tftd(w))); hold on;
stem(w_discr, abs(X_tfd));
title("Magnitud de X(e^{j\omega})")
subplot(2,1,2)
plot(w, angle(X_tftd(w))); hold on;
stem(w_discr, angle(X_tfd));
title("Fase de X(e^{j\omega})")