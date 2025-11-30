%% 1 (b,c,d,e)
w = linspace(-pi,pi,1000);

A = sin(2*w)./sin(w/2);
Psi = -3/2*w;

H_mag = abs(A);
H_fase = Psi +pi.*(w>pi/2) -pi.*(w<-pi/2);

figure
plot(w, H_mag,Linewidth=2); hold on
plot([-pi -pi/2 0 pi/2 pi], [0 0 4 0 0], 'o',LineWidth=3)
title("Magnitud |H(e^{j\omega})|")
xlabel("\omega");ylabel("|H(e^{j\omega})|")
xticks([-pi -pi/2 0 pi/2 pi])
xticklabels(["-\pi" "-\pi/2" "0" "\pi/2" "\pi"])
grid on

figure
plot(w, A,Linewidth=2); hold on
plot([-pi -pi/2 0 pi/2 pi], [0 0 4 0 0], 'o',LineWidth=3)
title("Amplitud A(e^{j\omega})")
xlabel("\omega");ylabel("A(e^{j\omega})")
xticks([-pi -pi/2 0 pi/2 pi])
xline([-pi/2 pi/2],'--', ["-\pi/2", "\pi/2"], LabelOrientation='horizontal')
xticklabels(["-\pi" "-\pi/2" "0" "\pi/2" "\pi"])
grid on

figure
plot(w, H_fase,Linewidth=2); hold on
title("Fase \angle{H(e^{j\omega})}")
xlabel("\omega");ylabel("\angle{H(e^{j\omega})}")
xline([-pi/2 pi/2],'--', ["-\pi/2", "\pi/2"], LabelOrientation='horizontal')
xticks([-pi -pi/2 0 pi/2 pi])
xticklabels(["-\pi" "-\pi/2" "0" "\pi/2" "\pi"])
yticks([-3*pi/4 -pi/2 -pi/4 0 pi/4 pi/2 3*pi/4])
yticklabels(["-3\pi/4" "-\pi/2" "-\pi/4" "0" "\pi/4" "\pi/2" "3\pi/4"])
grid on

figure
plot(w, Psi,Linewidth=2); hold on
title("Ángulo \Psi(\omega)")
xlabel("\omega");ylabel("\Psi(\omega)")
xticks([-pi -pi/2 0 pi/2 pi])
xticklabels(["-\pi" "-\pi/2" "0" "\pi/2" "\pi"])
yticks((-1.5:0.5:1.5)*pi)
yticklabels(["-3\pi/2" "-\pi" "-\pi/2" "0" "\pi/2" "\pi" "3\pi/2"])
grid on



%% 2 (c)

M = 124;
wc = 0.475*pi;

% Forma manual
n=0:M;
h_ideal = -sin(wc*(n-M/2))./(pi* (n-M/2));
%h_ideal = sin(pi*(n-M/2))./(pi* (n-M/2))-sin(wc*(n-M/2))./(pi* (n-M/2));
h_ideal(isnan(h_ideal)) = -wc/pi;
h_ideal(M/2+1) = h_ideal(M/2+1) + 1; % M/2+1 porque matlab indexa desde uno.

h_HP = h_ideal.*hann(M+1)';

% Usando fir1
h_fir1 = fir1(M,wc/pi,"high",hann(M+1));

dif_rms = rms(h_HP-h_fir1) % Son prácticamente idénticas.

% Ploteo
h = h_HP;
%h = h_fir1
w = linspace(0, pi, 1000);
H = freqz(h, 1, w);

delta_p = 0.0115;
delta_s = 0.0080;
ws = 0.45*pi; % = 2pi*Fs/Fm
wp = 0.5*pi;  % = 2pi*Fp/Fm

figure;
subplot(2,1,1)
stem(n, h,"filled",Linewidth=1)
title("Respuesta a impulso del filtro pasa-alto")
xlabel("n")
ylabel("h[n]")

subplot(2,1,2)
plot(w, abs(H),Linewidth=2)
xlim([0, pi])
xticks([0, 0.5, 1]*pi); xticklabels(["0", "\pi/2", "\pi"])
xline(wp, '--', '\omega_p', LabelOrientation="horizontal")
xline(ws, '--', '\omega_s', LabelOrientation="horizontal")
yline(1+delta_p, '--', '1+\delta_p')
yline(1-delta_p, '--', '1-\delta_p', LabelVerticalAlignment="bottom")
yline(delta_s, '--', '\delta_s')
title("Respuesta de magnitud")
xlabel("\omega")
ylabel("|H(e^{j\omega})|")

%% 2 (d)

F1 = 16000; F2 = 8000;
% Señal continua
x_cont = @(t) cos(2*pi*F1*t) + sin(2*pi*F2*t);

% Muestreo
Fm = 48000; % Frec. muestreo
T = 1/Fm;
nT = 0:T:0.1;
x_muestreada = x_cont(nT);

x_filtrada = filter(h_HP, 1, x_muestreada);

% Aproximacion de TFTC
f_m = abs(fftshift(fft(x_muestreada)*T));
f_f = abs(fftshift(fft(x_filtrada)*T));

% % Ploteamos una porción de la señal
n = 0:1000;
x_muestreada = x_muestreada(n+1);
x_filtrada = x_filtrada(n+1);

x_m_dac = interp(x_muestreada, 10);
x_f_dac = interp(x_filtrada, 10);
n_dac = (0:length(x_m_dac)-1) / 10; 

% ploteo fourier
N = length(f_m);
F = (-N/2:N/2-1)*(1/(N*T));

figure;
% Ploteo de la señal filtrada
subplot(2,2,1)
stem(n*T, x_muestreada, 'filled', 'LineWidth', 2); hold on
plot(n_dac*T, x_m_dac, '--', Linewidth=1.5)
xlim([0.01 0.0103])
xlabel("Tiempo (s)")
ylabel("Amplitud")
title("Señal original")

subplot(2,2,2)
plot(F, f_m, LineWidth=2)
title("Transformada de Fourier (aprox.) de la señal original")
xlabel("F")
ylabel("X(2{\pi}F)")
xticks([-16 -8 8 16]*1000)
xticklabels(["-16 kHz" "-8 kHz" "8 kHz" "16 kHz"])

subplot(2,2,3)
stem(n*T, x_filtrada,'filled', LineWidth=2); hold on
plot(n_dac*T, x_f_dac, '--', Linewidth=1.5)
xlim([0.01 0.0103])
xlabel("Tiempo (s)")
ylabel("Amplitud")
title('Señal filtrada')

subplot(2,2,4)
plot(F, f_f, LineWidth=2)
title("Transformada de Fourier (aprox.) de la señal filtrada")
xlabel("F")
ylabel("X(2{\pi}F)")
xticks([-16 -8 8 16]*1000)
xticklabels(["-16 kHz" "-8 kHz" "8 kHz" "16 kHz"])