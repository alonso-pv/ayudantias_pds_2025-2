%% 1
k = 1:4
pk = 40*pi*exp( 1j*( pi/2 + (2*k-1)/8*pi ) )

figure
plot(real(pk), imag(pk), 'x', LineWidth=2, MarkerSize=10)
rectangle("Position",[-1 -1 2 2 ]*40*pi,'Curvature',[1 1],LineStyle='--')
grid on
title("Polos del filtro Butterworth")
xticks([-1 0 1]*40*pi)
xticklabels(["-40\pi" "0" "40\pi"])
yticks([-1 0 1]*40*pi)
yticklabels(["-40\pi" "0" "40\pi"])

%% 2

Fp = 50;
Fs = 80;

Omegap = 100*pi;
Omegas = 160*pi;
Ap = 0.5;
As = 45;


[N, Omegac] = buttord(Omegap, Omegas, Ap, As, 's')
[z, p, k] = butter(N, Omegac, 's')


abs(p)

Omega = 2*pi*logspace(0, 3, 1024);

[b, a] = zp2tf(z,p,k);
h = freqs(b,a,Omega);
h_mag = abs(h);
h_fase = angle(h);

figure
plot(real(p), imag(p), 'x', LineWidth=2)
lim = [-Omegac Omegac]*1.1; xlim(lim); ylim(lim); grid on
rectangle("Position",[-1 -1 2 2 ]*Omegac,'Curvature',[1 1],LineStyle='--')
grid on
title("Polos del filtro Butterworth")
xticks([-1 0 1]*347.18)
xticklabels(["-347.18" "0" "347.18"])
yticks([-1 0 1]*347.18)
yticklabels(["-347.18" "0" "347.18"])

figure
subplot(1,2,1)
semilogx(Omega/(2*pi), mag2db(h_mag), LineWidth=2); hold on
semilogx(Omegac/(2*pi),mag2db(0.707),'x', Linewidth=2)
xline([Fp Fs], '--', ["F_p=50Hz" "F_s=80Hz"],LabelVerticalAlignment="bottom")
yline([-Ap -As], '--', ["A_p=0.5 dB" "A_s=45 dB"])
yline([0], '--', ["0 dB"], LabelHorizontalAlignment='left')
title("Magnitud (dB)")
ylabel("Frecuencia (Hz)")
xlabel("Magnitud (dB)")

subplot(1,2,2)
semilogx(Omega/(2*pi), unwrap(h_fase), LineWidth=2); hold on
title("Fase")
xlabel("Frecuencia (Hz)")
ylabel("Fase (rad)")
yticks((-7:0)*pi)
yticklabels(["-7\pi" "-6\pi" "-5\pi" "-4\pi" "-3\pi" "-2\pi" "-1\pi" "0"])

%% 2 (e)
Td = 1/1000;
[bz, az] = impinvar(b,a, 1/Td);

t = linspace(0,0.12,1000);
[ht, tout] = impulse(tf(b, a), t); 
[hn, nT]= impz(bz, az, 120, 1/Td);

w = linspace(0,pi,1000);
H = freqz(bz, az, w);

figure
plot(tout, ht*Td, LineWidth=2); hold on
stem(nT, hn, "filled")
title("Respuesta a impulso del filtro")
legend("h(t)*T_d", "h[n]", fontsize=15)

Omegap = 100*pi;
Omegas = 160*pi;
Ap = 0.5;
As = 45;

figure
subplot(1,2,1)
plot(w, mag2db(abs(H)), Linewidth=2); grid on
xline([Omegap*Td Omegas*Td], '--', ["\Omega_pT_d" "\Omega_sT_d"],LabelVerticalAlignment="bottom")
yline([-Ap -As], '--', ["A_p=0.5 dB" "A_s=45 dB"])
yline([0], '--', ["0 dB"], LabelHorizontalAlignment='left')
title("Magnitud (dB) de H_d(e^{j\omega})")
xlabel("\omega")
ylabel("|H(e^{j\omega})| (dB)")

subplot(1,2,2)
plot(w, unwrap(angle(H)), Linewidth=2); grid on
title("Fase (rad) de H_d(e^{j\omega})")
xlabel("\omega")
ylabel("\angle{H(e^{j\omega})} (rad)")


%% 3
wp = 0.2*pi;
ws = 0.3*pi;


Td = 2;
Omegap = 0.325;
Ap = 1;
Omegas = 0.509;
As = 60;

[N, Omegac] = cheb1ord(Omegap, Omegas, Ap, As, 's')
[b, a] = cheby1(N, Ap, Omegac, 's');
[z, p, k] = cheby1(N, Ap, Omegac, 's');

figure
plot(real(p), imag(p), 'x', LineWidth=2)
lim = [-Omegac Omegac]*1.1; xlim(lim); ylim(lim); grid on
rectangle("Position",[-1 -1 2 2 ]*Omegac,'Curvature',[1 1],LineStyle='--')


% Omega = 2*pi*logspace(-2, 0, 1024);
% 
% h = freqs(b,a,Omega);
% h_mag = abs(h);
% h_fase = angle(h);

% figure
% plot(real(p), imag(p), 'x', LineWidth=2)
% lim = [-Omegac Omegac]*1.1; xlim(lim); ylim(lim); grid on
% rectangle("Position",[-1 -1 2 2 ]*Omegac,'Curvature',[1 1],LineStyle='--')
% 
% figure
% subplot(1,2,1)
% semilogx(Omega, mag2db(h_mag), LineWidth=2); hold on
% semilogx(Omegac,mag2db(0.707),'x', Linewidth=2)
% xline([Omegap Omegas], '--', ["\Omega_p=0.325" "\Omega_s=0.509"],LabelVerticalAlignment="bottom")
% yline([-Ap -As], '--', ["A_p=1 dB" "A_s=60 dB"])
% yline(0, '--', "0 dB", LabelHorizontalAlignment='left')
% 
% subplot(1,2,2)
% semilogx(Omega, unwrap(h_fase), LineWidth=2); hold on


[bz, az] = bilinear(b, a, 1/Td)
[hz, w]= freqz(bz, az, 1024);

figure
subplot(1,2,1)
plot(w, mag2db(abs(hz)), Linewidth=2)
xline([wp ws], '--', ["\omega_p=0.2\pi" "\omega_s=0.3\pi"],LabelVerticalAlignment="bottom")
yline([-Ap -As], '--', ["A_p=1 dB" "A_s=60 dB"])
yline([0], '--', ["0 dB"], LabelHorizontalAlignment='left')
title("Magnitud (dB) de H_d(e^{j\omega})")
xlabel("\omega")
ylabel("|H_d(e^{j\omega})| (dB)")

subplot(1,2,2)
semilogx(w, unwrap(angle(hz)), LineWidth=2); hold on
title("Fase de H_d(e^{j\omega})")
xlabel("\omega")
ylabel("\angle{H_d(e^{j\omega})}")

figure
plot(w, mag2db(abs(hz)), Linewidth=2)
xline([wp ws], '--', ["\omega_p=0.2\pi" "\omega_s=0.3\pi"],LabelVerticalAlignment="bottom")
yline([-Ap -As], '--', ["A_p=1 dB" "A_s=60 dB"])
yline([0], '--', ["0 dB"], LabelHorizontalAlignment='left')
title("Magnitud (dB) de H_d(e^{j\omega})")
xlabel("\omega")
ylabel("|H_d(e^{j\omega})| (dB)")