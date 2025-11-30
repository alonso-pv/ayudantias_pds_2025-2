%% 1 b)
c = @(k) ...
    (k==-8)* 3*exp(-1j*pi/3) + ...
    (k==-3)* 2j + ...
    (k==0)*  2 + ...
    (k==3)*  -2j + ...
    (k==8)*  3*exp(1j*pi/3);

k = -10:10;

figure
subplot(2,1,1)
stem(k, abs(c(k)))
xlabel('k');
ylabel('Magnitud');
title('|ck|');
grid on; hold on;


subplot(2,1,2)
stem(k, angle(c(k)))
xlabel('k');
ylabel('Fase');
title('Fase de ck');
grid on; hold on;


%% 2 d)
X   = @(om) ( exp(1j*om+1) - exp(-1j*om-1) )./(1j*om+1);
c = @(k) ( exp(1j*k*pi + 1) - exp(-1j*k*pi - 1) )./(2j*k*pi+2);

om_0 = pi;

k = -10:1:10;
om = linspace(-10*om_0, 10*om_0, 1000);

% Magnitud
figure/
subplot(2,1,1)
stem(k*om_0, abs(c(k)), 'o', 'color', 'k');
hold on;
%plot(om, abs(X(om)), '-');
plot(om, abs(X(om)/2), '-');
title('Gráfico de magnitud');
xlabel('Frequencia (rad/s)');
ylabel('Magnitud');
grid on; hold on;

% Fase
subplot(2,1,2)
stem(k*om_0, angle(c(k)), 'o', 'color', 'k');
hold on;
%plot(om, angle(X(om)), '-')
plot(om, angle(X(om)/2), '-')
title('Gráfico de fase');
xlabel('Frequencia (rad/s)');
ylabel('Fase (rad)');

%% 3 b)
X2z = @(z) z.*sin(0.1*pi)./(z.^2-2*z*cos(0.1*pi)+1) .* (1+z.^-10);
X2ejw = @(w) X2z(exp(1j*w));

w = linspace(-10, 10, 1000);

figure
subplot(2,1,1)
plot(w, abs(X2ejw(w)), 'r-');
xlabel('Frequencia (rad/s)');
ylabel('Magnitud');
title('Magnitud de X2(e^{jw})');
grid on; hold on;

subplot(2,1,2)
plot(w, unwrap(angle(X2ejw(w))), 'b-');
xlabel('Frecuencia (rad/s)');
ylabel('Fase');
title('Fase de X2(e^{jw})');
grid on; hold on;

%% 4 b)
k = 0:11;
x = 1-sin(pi*k/4);
N = 12;

c_k = 1/12 * fft(x)

figure
subplot(2,1,1)
stem(k, abs(c_k))
xlabel('k');
ylabel('Magnitud');
title('|ck|');
grid on; hold on;


subplot(2,1,2)
stem(k, angle(c_k))
xlabel('k');
ylabel('Fase');
title('Fase de ck');
grid on; hold on;