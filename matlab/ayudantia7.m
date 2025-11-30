%% 1 (b)
N = 4;
x = [1 1 0 3];
z = x(mod((0:3) - 2,N)+1)


figure
subplot(2,1,1)
stem(0:3, x, 'filled', LineWidth=2); hold on;
stem(-4:-1, x, 'filled', 'r', LineWidth=2);
stem(4:7, x, 'filled', 'r', LineWidth=2);
xlim([-4, 7])
legend('x[n]', 'x[n] periódica')
title("x[n] y extensión periódica")

subplot(2,1,2)
stem(0:3, z, 'filled', LineWidth=2);
xlim([-4, 7])
title("z[n]")

%% 3 (a)

x = [1 1 0 3];
X = fftrecur(x)

%% 3 (b)

K = 10; % N=2^1 hasta 2^10
reps = 50; % Cada prueba se repite 50 veces y se promedia

k_vec = 1:K;
tiempos_direct = zeros(1,K);
tiempos_fft = zeros(1,K);

for k = k_vec
    for r = 1:reps
        x = rand(1,2^k);

        tic;
        dftdirect(x);
        tiempos_direct(k) = tiempos_direct(k) + toc;

        tic;
        fftrecur(x);
        tiempos_fft(k) = tiempos_fft(k) + toc;
    end
end

figure
subplot(2,1,1)
plot(k_vec, tiempos_direct./reps, 'LineWidth', 2); hold on
plot(k_vec, tiempos_fft./reps, 'LineWidth', 2)
legend("dft direct", "fftrecur")
xlabel("K")
ylabel("Tiempo (segundos)")
title("Tiempo de ejecucion de TFD, N=2^K")
subplot(2,1,2)
semilogy(k_vec, tiempos_direct./reps, 'LineWidth', 2); hold on
semilogy(k_vec, tiempos_fft./reps, 'LineWidth', 2)
legend("dft direct", "fftrecur")
xlabel("K")
ylabel("Tiempo (segundos) (escala logaritmica)")
title("Tiempo de ejecucion de TFD, N=2^K (escala logaritmica)")

%% Funciones

function Xdft = fftrecur(x)
% Recursive computation of the DFT using divide & conquer
% N should be a power of 2
N = length(x);
if N == 1
    Xdft = x;
else
    m = N/2;
    Xp = fftrecur(x(1:2:N)); % 1:2:N = [1 3 5 ...]
    Xi = fftrecur(x(2:2:N));
    W = exp(-2j*pi/N).^((0:m-1)');
    temp = W.*Xi;
    Xdft = [ Xp+temp ; Xp-temp ];
end
end

function Xdft=dftdirect(x)
% Direct computation of the DFT
N=length(x); Q=2*pi/N;
for k=1:N
    S=0;
    for n=1:N
        W(k,n)=exp(-1j*Q*(k-1)*(n-1));
        S=S+W(k,n)*x(n);
    end
    Xdft(k)=S;
end
end