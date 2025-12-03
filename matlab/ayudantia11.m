%% 2

Fp = 50;
Fs = 80;

Omegap = 100*pi;
Omegas = 160*pi;
Ap = 0.5;
As = 45;

Omega = 2*pi*logspace(0, 3, 1024);

[N, Omegac] = buttord(Omegap, Omegas, Ap, As, 's')
[z, p, k] = butter(N, Omegac, 's')

abs(p)

[b, a] = zp2tf(z,p,k);
h = freqs(b,a,Omega);
h_mag = abs(h);
h_fase = angle(h);

figure
plot(real(p), imag(p), 'x', LineWidth=2)
lim = [-Omegac Omegac]*1.1; xlim(lim); ylim(lim); grid on
rectangle("Position",[-1 -1 2 2 ]*Omegac,'Curvature',[1 1],LineStyle='--')

figure
subplot(1,2,1)
semilogx(Omega/(2*pi), mag2db(h_mag), LineWidth=2); hold on
semilogx(Omegac/(2*pi),mag2db(0.707),'x', Linewidth=2)
xline([Fp Fs], '--', ["F_p=50Hz" "F_s=80Hz"],LabelVerticalAlignment="bottom")
yline([-Ap -As], '--', ["A_p=0.5 dB" "A_s=45 dB"])
yline([0], '--', ["0 dB"], LabelHorizontalAlignment='left')

subplot(1,2,2)
semilogx(Omega/(2*pi), unwrap(h_fase), LineWidth=2); hold on

%% 2 (e)

fs = 1000;
[bz, az] = impinvar(b, a, fs);
freqz(bz, az, 1024)

figure
impulse(tf(b, a)); hold on
[hn, t]= impz(bz, az, [], fs);
stem(t, hn)

%% 3
wp = 0.2*pi;
ws = 0.3*pi;


Td = 2;
Omegap = 0.325;
Ap = 1;
Omegas = 0.509;
As = 60;


[N, Omegac] = cheb1ord(Omegap, Omegas, Ap, As, 's')
%[b, a] = cheby1(N, Ap, Omegac, 's')
[z, p, k] = cheby1(N, Ap, Omegac, 's')

figure
plot(real(p), imag(p), 'x', LineWidth=2)
lim = [-Omegac Omegac]*1.1; xlim(lim); ylim(lim); grid on
rectangle("Position",[-1 -1 2 2 ]*Omegac,'Curvature',[1 1],LineStyle='--')


Omega = 2*pi*logspace(-2, 0, 1024);

h = freqs(b,a,Omega);
h_mag = abs(h);
h_fase = angle(h);

figure
plot(real(p), imag(p), 'x', LineWidth=2)
lim = [-Omegac Omegac]*1.1; xlim(lim); ylim(lim); grid on
rectangle("Position",[-1 -1 2 2 ]*Omegac,'Curvature',[1 1],LineStyle='--')

figure
subplot(1,2,1)
semilogx(Omega, mag2db(h_mag), LineWidth=2); hold on
semilogx(Omegac,mag2db(0.707),'x', Linewidth=2)
xline([Omegap Omegas], '--', ["\Omega_p=0.325" "\Omega_s=0.509"],LabelVerticalAlignment="bottom")
yline([-Ap -As], '--', ["A_p=1 dB" "A_s=60 dB"])
yline([0], '--', ["0 dB"], LabelHorizontalAlignment='left')

subplot(1,2,2)
semilogx(Omega, unwrap(h_fase), LineWidth=2); hold on

%%

[bz, az] = bilinear(b, a, 1/Td)
[hz, w]= freqz(bz, az, 1024);

figure
subplot(1,2,1)
plot(w, mag2db(abs(hz)), Linewidth=2)
xline([wp ws], '--', ["w_p=0.2\pi" "w_s=0.3\pi"],LabelVerticalAlignment="bottom")
yline([-Ap -As], '--', ["A_p=1 dB" "A_s=60 dB"])
yline([0], '--', ["0 dB"], LabelHorizontalAlignment='left')

subplot(1,2,2)
semilogx(w, unwrap(angle(hz)), LineWidth=2); hold on
