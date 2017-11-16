%Aim   : Training MLP(20,H,3) 

% Algorithm: Levenverg-Marquardt
Nh = 10; % Hidden Nodes
Epoch = 200; % Epochs
iter = 1; %Runs to find the best weight
itime = tic;
dataset = 'A';
clases = 10;
trainperc = 0.7;

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

cd '../'
[features,target] = etl_param(2400,50,dataset,clases);
cd 'MLP'

for i=1:iter
    cd '../'
    [Xe,Ye,Xv,Yv] = sort_rows(features,target,clases,trainperc);
    cd 'MLP'
    [net, Tr] = bp_lm(Xe,Ye,Nh,Epoch);
    Z = sim(net,Xv);
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

ftime = toc(itime);

fprintf('\nEntrenamiento finalizado %f minutos.\n',ftime/60);