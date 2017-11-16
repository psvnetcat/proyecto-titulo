
% Parámetros del algoritmo
dataset = 'E';
clases = 10;
trainperc = 0.7;
iter = 30;

% Parámetros de los autoencoder
hiddenSize1 = 102;
hiddenSize2 = 25;
param = [0.0140136987737066;98.6471630667665;0.275927505721519;0.0113151582357268;94.0828693469745;0.209272454869506];

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
    disp(i)
end

%{
figure(1)
plot(1:iter,AccG,'-o');
legend('testing')
legend('Location','southwest')
legend('boxoff')
ylim([85.5 100])
xlabel('Trial number')
ylabel('Accuracy (%)')
title('A')
%}

%save rsltEgrid6 AccG Acc Fsc param iter trainperc hiddenSize1 hiddenSize2