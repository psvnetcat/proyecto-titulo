% Parámetros del algoritmo
dataset = ['A','B','C','D','E'];
clases = 10;
trainperc = 0.7;

% Nodos ocultos 
hiddenSize1 = 102;
hiddenSize2 = 25;

% Variables
AccG = zeros(5,10);
%grid = zeros(6,10);

%{
a = 0.0002;
b = 0.022;
c = 91;
d = 99;
e = 0.00002;
f = 0.4;

grid(1,:) = (b-a).*rand(10,1) + a;
grid(2,:) = (d-c).*rand(10,1) + c;
grid(3,:) = (f-e).*rand(10,1) + e;
grid(4,:) = (b-a).*rand(10,1) + a;
grid(5,:) = (d-c).*rand(10,1) + c;
grid(6,:) = (f-e).*rand(10,1) + e;

% Funciones
fp = @(confusionMat) sum(confusionMat,1)'-diag(confusionMat);
fn = @(confusionMat) sum(confusionMat,2)-diag(confusionMat);
precision = @(confusionMat) diag(confusionMat)./(diag(confusionMat)+fp(confusionMat));
sensibilidad = @(confusionMat) diag(confusionMat)./(diag(confusionMat)+fn(confusionMat));
fscore = @(confusionMat) 2*diag(confusionMat)./(2*diag(confusionMat)+fp(confusionMat)+fn(confusionMat));
traza = @(confusionMat) repmat(trace(confusionMat),1,clases)';
exactitud = @(confusionMat) (traza(confusionMat)./(fp(confusionMat)+fn(confusionMat)+traza(confusionMat)))';
%}

for j=1:size(dataset,2)
    
    [features,target] = etl_param(2048,59,dataset(j),clases);
    [Xe,Ye,Xv,Yv] = sort_rows(features,target,clases,trainperc);
    
    for i=1:size(grid,2)
        deepnet = training(hiddenSize1,hiddenSize2,Xe,Ye,grid(1,i),grid(2,i),grid(3,i),grid(4,i),grid(5,i),grid(6,i));
        Z = deepnet(Xv); 
        [c,cm] = confusion(Yv,Z);
        AccG(j,i) = (1-c)*100;
    end
end
