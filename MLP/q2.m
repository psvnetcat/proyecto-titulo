clear
load perfData
load MLPtest

% Test de la red óptima
Z = sim(net,Xv);
er = Yv -Z;

% obtencion F-score
[c,cm,ind,per] = confusion(Yv,Z);

for i=1:2
    precision = per(i,2)/(per(i,2)+per(i,2));
    recall = per(i,2)/(per(i,3)+per(i,1));
    fscore(i) = 2*(precision*recall)/(precision+recall);
end
fprintf('\nF-score:\n');
disp(fscore)

% Confusion Matrix
figure(3)
plotconfusion(Yv,Z)
title('Confusion matrix')
axis tight
grid on

% Plot Nh vs MSE
figure(1)
plot(1:Nh,log(bestMSE),'-x')
title('Nh vs MSE')
xlabel('Hidden Number')
ylabel('MSE (dB)')
axis tight
grid on

% Plot Epoch vs MSE
figure(2)
plot(log(bFit),'-r')
title('Epoch vs MSE')
xlabel('Iterations')
ylabel('MSE (dB)')
axis tight
grid on
