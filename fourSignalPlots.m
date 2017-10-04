
cd 'A/o3';
load '234.mat'
cd '../../'
ball = X234_DE_time;

cd 'B/o3';
load '235.mat'
cd '../../'
inner = X235_DE_time;

cd 'C/o3';
load '236.mat';
cd '../../'
outer = X236_DE_time;

cd 'D/o3';
load '237.mat';
cd '../../'
normal = X237_DE_time;


% ===================================================== %
window = 3636;
t = linspace(0,0.3,window);

figure
subplot(2,2,1)       % add first plot in 2 x 1 grid
plot(t,ball(1:window,1));
xlabel('Tiempo (s)')
ylabel('Amplitud (m/s^2)')
ylim([-6 6])
title('OF 0.021 0 hp')

subplot(2,2,2)       % add second plot in 2 x 1 grid
plot(t,inner(1:window,1));
xlabel('Tiempo (s)')
ylabel('Amplitud (m/s^2)')
ylim([-6 6])
title('OF 0.021 1 hp')

subplot(2,2,3)       % add second plot in 2 x 1 grid
plot(t,outer(1:window,1));
xlabel('Tiempo (s)')
ylabel('Amplitud (m/s^2)')
ylim([-6 6])
title('OF 0.021 2 hp')

subplot(2,2,4)       % add second plot in 2 x 1 grid
plot(t,normal(1:window,1));
xlabel('Tiempo (s)')
ylabel('Amplitud (m/s^2)')
ylim([-6 6])
title('OF 0.021 3 hp')


%{
signal = [ball(1:12000,1),inner(1:12000,1),outer(1:12000,1),normal(1:12000,1)];
for i=1:4
    Fs = 12000;            % Sampling frequency                    
    T = 1/Fs;             % Sampling period       
    L = 12000;             % Length of signal
    t = (0:L-1)*T;        % Time vector
    S = signal(:,i);
    Y = fft(S);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
    frecuencias(:,i) = f;
    amplitudes(:,i) = P1;
end

figure
subplot(2,2,1)       % add first plot in 2 x 1 grid
plot(frecuencias(:,1),amplitudes(:,1));
xlabel('frecuencia [Hz]')
ylabel('|X(k)|')
title('Espectro de amplitud - falla en la bola')

subplot(2,2,2)       % add first plot in 2 x 1 grid
plot(frecuencias(:,2),amplitudes(:,2));
xlabel('frecuencia [Hz]')
ylabel('|X(k)|')
title('Espectro de amplitud - falla en anillo interno')

subplot(2,2,3)       % add first plot in 2 x 1 grid
plot(frecuencias(:,3),amplitudes(:,3));
xlabel('frecuencia [Hz]')
ylabel('|X(k)|')
title('Espectro de amplitud - falla en anillo externo')

subplot(2,2,4)       % add first plot in 2 x 1 grid
plot(frecuencias(:,4),amplitudes(:,4));
xlabel('frecuencia [Hz]')
ylabel('|X(k)|')
title('Espectro de amplitud - normal')
%}

%{
A = ones(1,50);
stem(A(1:50))
xlabel('número de muestras')
ylabel('Amplitud')
title('Ventana rectangular')
%}
