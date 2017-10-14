
% Parámetros del algoritmo
dataset = 'E';
clases = 10;
trainperc = 0.7;
iter = 30;

% Parámetros de los autoencoder
hiddenSize1 = 102;
hiddenSize2 = 25;
param = [0.0162906665906445;96.6491152028911;0.130050141545906;0.00467805401358500;97.8639996678380;0.385538479498422];

% Otros
AccG = zeros(1,iter);
Fsc = zeros(iter,clases);
Acc = zeros(iter,clases);

% Funciones
fp = @(confusionMat) sum(confusionMat,1)'-diag(confusionMat);
fn = @(confusionMat) sum(confusionMat,2)-diag(confusionMat);
precision = @(confusionMat) diag(confusionMat)./(diag(confusionMat)+fp(confusionMat));
sensibilidad = @(confusionMat) diag(confusionMat)./(diag(confusionMat)+fn(confusionMat));
fscore = @(confusionMat) 2*diag(confusionMat)./(2*diag(confusionMat)+fp(confusionMat)+fn(confusionMat));
traza = @(confusionMat) repmat(trace(confusionMat),1,clases)';
exactitud = @(confusionMat) (traza(confusionMat)./(fp(confusionMat)+fn(confusionMat)+traza(confusionMat)))';

[features,target] = etl_param(2048,59,dataset,clases);

for i=1:iter
    % Reordenamiento
    [Xe,Ye,Xv,Yv] = sort_rows(features,target,clases,trainperc); 
    deepnet = training(hiddenSize1,hiddenSize2,Xe,Ye,param(1),param(2),param(3),param(4),param(5),param(6));
    Z = deepnet(Xv); 
    [c,cm] = confusion(Yv,Z);
    % Global Accuracy
    AccG(1,i) = (1-c)*100;
    % Fscore
    Fsc(i,:) = fscore(cm);
    % Accuracy
    Acc(i,:) = exactitud(cm);
end

%{
figure(1)
plot(1:iter,AccG,'-o');
legend('testing')
legend('Location','southwest')
legend('boxoff')
ylim([98.5 100])
xlabel('Trial number')
ylabel('Accuracy (%)')
title('E')
%}

%save rsltEnuevomejorE AccG Acc Fsc param iter trainperc hiddenSize1 hiddenSize2