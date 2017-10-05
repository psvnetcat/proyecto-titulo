% Parámetros main
dataset = ['A';'B';'C';'D'];
clases = 10;
trainperc = 0.7;

% Parámetros de los autoencoder
hiddenSize1 = 102;
hiddenSize2 = 25;

AccG = zeros(4,10);

%{
a = 0.00001;
b = 0.02;
c = 91;
d = 99;
e = 0.00002;
f = 0.4;

grid(1,:) = (b-a).*rand(1,1) + a;
grid(2,:) = (d-c).*rand(1,1) + c;
grid(3,:) = (f-e).*rand(1,1) + e;

% Funciones
fp = @(confusionMat) sum(confusionMat,1)'-diag(confusionMat);
fn = @(confusionMat) sum(confusionMat,2)-diag(confusionMat);
precision = @(confusionMat) diag(confusionMat)./(diag(confusionMat)+fp(confusionMat));
sensibilidad = @(confusionMat) diag(confusionMat)./(diag(confusionMat)+fn(confusionMat));
fscore = @(confusionMat) 2*diag(confusionMat)./(2*diag(confusionMat)+fp(confusionMat)+fn(confusionMat));
traza = @(confusionMat) repmat(trace(confusionMat),1,clases)';
exactitud = @(confusionMat) (traza(confusionMat)./(fp(confusionMat)+fn(confusionMat)+traza(confusionMat)))';
%}

for j=1:size(dataset,1)
    [features,target] = etl_param(2400,50,dataset(j),clases);
    % Reordenamiento
    [Xe,Ye,Xv,Yv] = sort_rows(features,target,clases,trainperc); 
    for i=1:size(grid,2)
        deepnet = training(hiddenSize1,hiddenSize2,Xe,Ye,0.015083046731704,98.337545895022200,0.153714921302500,0.015083046731704,98.337545895022200,0.153714921302500);
        % Exactitud testing
        Z = deepnet(Xv); 
        [c,cm] = confusion(Yv,Z);
        AccG(j,i) = (1-c)*100;
    end
end
