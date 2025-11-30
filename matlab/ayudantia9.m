%% 2

w = linspace(-pi, pi, 1000);

% --- Tipo I ---
h = [1, 2, -1, 5, -1, 2, 1];    M = 6; % M par, simetría par
A = 2*cos(3*w) +4*cos(2*w) -2*cos(w) + 5;
psi = -M/2*w;

% --- Tipo II ---
%h = [1, 2, -1, -1, 2, 1];      M = 5; % M impar, simetría par
%A = 2*cos(5/2*w) +4*cos(3/2*w) -2*cos(1/2*w);
%psi = -M/2*w;

% --- Tipo III ---
%h = [1, 2 -1, 0, 1, -2, -1];   M = 6; % M par, simetría impar
%A = 2*sin(3*w) +4*sin(2*w) -2*sin(w);
%psi = pi/2-M/2*w;

% --- Tipo IV ---
%h = [1, 2, -1, 1, -2, -1];     M = 5; % M impar, simetría impar
%A = 2*sin(5/2*w) + 4*sin(3/2*w) - 2*sin(1/2*w);
%psi = pi/2-M/2*w;


% Alternativamente amplitud se obtiene como: A(e^jw) = H(e^jw)*e^-jPsi(w)
%H = freqz(h, 1, w);
%A = real(H.*exp(-1j*psi));


figure;
n = 0:M;

subplot(2, 2, 1)
stem(n, h, 'filled', Linewidth=2);
xlabel('n');
ylabel('h[n]');
title('Respuesta a impulso');
grid on;

subplot(2,2,2)
plot(w, A, Linewidth=2); hold on
xlabel('Frecuencia \omega');
ylabel('Amplitud A(e^{j\omega})');
title('Respuesta de amplitud');
grid on;

subplot(2,2,3)
%plot(w, unwrap(angle(H)), Linewidth=2); hold on;
plot(w, psi, Linewidth=2)
xlabel('Frecuencia \omega');
ylabel('Ángulo \Psi(\omega)');
title('Respuesta de ángulo');
grid on;

subplot(2,2,4)
zplane(h,1)
title('Polos y ceros del sistema');
grid on;

%% 3 (a)

n = -30:30;

wc = 0.4*pi;
wc = pi;
a = 0;
h_ideal = sin(wc*(n-a))./(pi* (n-a));
h_ideal(isnan(h_ideal)) = wc/pi;

h_cont = @(t) sin(wc*(t-a))./(pi* (t-a));
figure
stem(n+a, h_ideal, "filled", Linewidth=2); hold on
fplot(h_cont, [-30 30], Linewidth=1, LineStyle="--")
xlabel('n');
ylabel('h[n]');
title('Respuesta a impulso');
grid on;

%% 3 (b)

% Especificaciones
wp = 0.3*pi; ws = 0.5*pi;
delta_p = 0.028; delta_s = 0.0032;

M = 8;
wc = 0.4*pi;
n_rect = 0:M;

h_rect = sin(wc*(n_rect-M/2))./(pi * (n_rect-M/2));
h_rect(isnan(h_rect)) = wc/pi;

w = linspace(0, pi, 1000);
H_rect = freqz(h_rect, 1, w);

subplot(1,2,1)
stem(n_rect,h_rect,'filled', LineWidth=2);
xlabel('n');
ylabel('h_{LP}[n]');
title('Respuesta a impulso');
grid on;


subplot(1,2,2)
plot(w, abs(H_rect), LineWidth=2)
xline(wp, '--', '\omega_p', LabelOrientation="horizontal", LineWidth=2)
xline(ws, '--', '\omega_s', LabelOrientation="horizontal", LineWidth=2)
yline(1+delta_p, '--', '1+\delta_p', LineWidth=2)
yline(1-delta_p, '--', '1-\delta_p', LineWidth=2)
yline(delta_s, '--', '\delta_s', LineWidth=2)
xlabel('Frecuencia \omega');
ylabel('Magnitud |H(e^{j\omega})|');
title('Respuesta de magnitud');
grid on;

%% 3 (c)

% Especificaciones
wp = 0.3*pi; ws = 0.5*pi;
delta_p = 0.028; delta_s = 0.0032;

M = 32; 
wc = 0.4*pi;
n_hamm = 0:M;

h_ideal = ( sin(wc*(n_hamm-M/2))./(pi * (n_hamm-M/2)) );
h_ideal(isnan(h_ideal)) = wc/pi;
h_hamming = h_ideal.*hamming(M+1)';


w = linspace(0, pi, 1000);
H_hamming = freqz(h_hamming, 1, w);

subplot(1,2,1)
stem(n_hamm,h_hamming,'filled', LineWidth=2);
xlabel('n');
ylabel('h_{LP}[n]');
title('Respuesta a impulso');
grid on;

subplot(1,2,2)
plot(w, abs(H_hamming), LineWidth=2)
xline(wp, '--', '\omega_p', LabelOrientation="horizontal")
xline(ws, '--', '\omega_s', LabelOrientation="horizontal")
yline(1+delta_p, '--', '1+\delta_p')
yline(1-delta_p, '--', '1-\delta_p')
yline(delta_s, '--', '\delta_s')
xlabel('Frecuencia \omega');
ylabel('Magnitud |H(e^{j\omega})|');
title('Respuesta de magnitud');
grid on;



%% Comparacion
subplot(2,2,1)
stem(n_rect,h_rect,'filled', LineWidth=2);
xlabel('n');
ylabel('h_{LP}[n]');
title('Respuesta a impulso');
grid on;

subplot(2,2,2)
plot(w, abs(H_rect), LineWidth=2)
xline(wp, '--', '\omega_p', LabelOrientation="horizontal")
xline(ws, '--', '\omega_s', LabelOrientation="horizontal")
yline(1+delta_p, '--', '1+\delta_p')
yline(1-delta_p, '--', '1-\delta_p')
yline(delta_s, '--', '\delta_s')
xlabel('Frecuencia \omega');
ylabel('Magnitud |H(e^{j\omega})|');
title('Respuesta de magnitud');
grid on;

subplot(2,2,3)
stem(n_hamm,h_hamming,'filled', LineWidth=2);
xlabel('n');
ylabel('h_{LP}[n]');
title('Respuesta a impulso');
grid on;

subplot(2,2,4)
plot(w, abs(H_hamming), LineWidth=2)
xline(wp, '--', '\omega_p', LabelOrientation="horizontal")
xline(ws, '--', '\omega_s', LabelOrientation="horizontal")
yline(1+delta_p, '--', '1+\delta_p')
yline(1-delta_p, '--', '1-\delta_p')
yline(delta_s, '--', '\delta_s')
xlabel('Frecuencia \omega');
ylabel('Magnitud |H(e^{j\omega})|');
title('Respuesta de magnitud');
grid on;