X = @(Om) (-abs(Om)+10*pi).*(-10*pi<Om & Om<10*pi)

T=1/8;


X_p = @(Om) X(Om+2*pi/T)+ X(Om+4*pi/T) + X(Om) + X(Om-2*pi/T) + X(Om-4*pi/T)
Om = linspace(-30*pi, 30*pi, 1000);
plot(Om, X_p(Om))
set(gca, 'Ytick', [])
xticks([-30 -16 -8 0 8 16 30]*pi)
xticklabels({'-30\pi', '-16\pi', '-8\pi', '0', '8\pi','16\pi','30\pi'})

%% 2.(b)

x_c = @(t) 2*cos(150*pi*t);
F_s = 300
T = 1/F_s

t = linspace(0, 0.03, 10000)
n = 0:9
figure
subplot(4,1,1)
plot(t, x_c(t),LineWidth=2); hold on;
stem(n*T, x_c(n*T))
axis([0 0.03 -2 2])
title("x_c(t)")


subplot(4,1,2)
stem(n, x_c(n*T), 'filled')
axis([0 9 -2 2])
title("x[n]")

x_roc = @(t) x_c(floor(t/T)*T)
subplot(4,1,3)
plot(t, x_roc(t), 'LineWidth', 2); hold on
plot(t, x_c(t-T/2), 'LineStyle','--');
axis([0 0.03 -2 2])
xticks((0:9)*T)
xticklabels(["0T" "1T" "2T" "3T" "4T" "5T" "6T" "7T" "8T" "9T"])
title("x_{SH}(t)")

subplot(4,1,4)
plot(t, x_c(t-T/2), 'LineWidth', 2);
title("x_r(t)")

%% 3 (c)
impulso = @(F,amp,sty) stem(F,amp,sty, 'filled','LineWidth',2)

F = -800:0.01:800;
F_zeros = zeros(size(F))
figure()
subplot(2,1,1)
plot(F,F_zeros, 'k'); hold on
impulso([-200 -100 100 200], [2 5/2 5/2 2]*pi, 'b^')
xticks([-200 -100 0 100 200])
yticks([2 5/2]*pi)
yticklabels(["2\pi" "5\pi/2"])
title("Magnitud del espectro original X(j2\piF)")

subplot(2,1,2)
plot(F,F_zeros, 'k'); hold on
impulso([-200 -100 100 200], [2 5/2 5/2 2]*pi, 'b^')
impulso([-200 -100 100 200]+500, [2 5/2 5/2 2]*pi, 'r^')
impulso([-200 -100 100 200]-500, [2 5/2 5/2 2]*pi, 'r^')
xticks([-700 -600 -500 -400 -300 -200 -100 0 100 200 300 400 500 600 700])
yticks([2 5/2]*pi)
yticklabels(["2\pi" "5\pi/2"])
title("Magnitud del espectro de la señal muestreada X(e^{j2\piFT})")

%%
figure
subplot(2,1,2)
plot(F,F_zeros, 'k'); hold on
impulso([-200 -100 100 200], [2 5/2 5/2 2]*pi, 'b^')
impulso([-200 -100 100 200]+500, [2 5/2 5/2 2]*pi, 'r^')
impulso([-200 -100 100 200]-500, [2 5/2 5/2 2]*pi, 'r^')
xticks([-700 -600 -500 -400 -300 -200 -100 0 100 200 300 400 500 600 700])
yticks([2 5/2]*pi)
yticklabels(["2\pi" "5\pi/2"])
xline([-250 250], '--', "LineWidth",2)
title("Magnitud del espectro de la señal muestreada X(e^{j2\piFT})")
%%
%impulso(200, 5/2, 'b')

% 3 (e)
F = -450:0.01:450;
F_zeros = zeros(size(F))
figure()
subplot(2,1,1)
plot(F,F_zeros, 'k'); hold on
impulso([-200 -100 100 200], [2 5/2 5/2 2]*pi, 'b^')
xticks([-200 -100 0 100 200])
yticks([2 5/2]*pi)
yticklabels(["2\pi" "5\pi/2"])
title("Magnitud del espectro original X(j2\piF)")

subplot(2,1,2)
plot(F,F_zeros, 'k'); hold on
impulso([-200 -100 100 200], [2 5/2 5/2 2]*pi, 'b^')
impulso([-200 -100 100 150 200 250]+350, [2 5/2 5/2 2 2 5/2]*pi, 'r^')
impulso([-250 -200 -150 -100 100 200]-350, [5/2 2 2 5/2 5/2 2]*pi, 'r^')
xticks([-550 -450 -350 -250 -200 -150 -100 0 100 150 200 250 350 450 550])
yticks([2 5/2]*pi)
yticklabels(["2\pi" "5\pi/2"])
title("Magnitud del espectro de la señal muestreada X(e^{j2\piFT})")
%xline([-175 175], '--', "LineWidth",2)

%%
subplot(2,1,2)
plot(F,F_zeros, 'k'); hold on
impulso([-200 -100 100 200], [2 5/2 5/2 2]*pi, 'b^')
impulso([-200 -100 100 150 200 250]+350, [2 5/2 5/2 2 2 5/2]*pi, 'r^')
impulso([-250 -200 -150 -100 100 200]-350, [5/2 2 2 5/2 5/2 2]*pi, 'r^')
xticks([-550 -450 -350 -250 -200 -150 -100 0 100 150 200 250 350 450 550])
yticks([2 5/2]*pi)
yticklabels(["2\pi" "5\pi/2"])
title("Magnitud del espectro de la señal muestreada X(e^{j2\piFT})")
xline([-175 175], '--', "LineWidth",2)