load 'NewGrid'

% Parámetros main
dataset = 'E';
clases = 10;
trainperc = 0.7;

% Parámetros de los autoencoder
hiddenSize1 = 102;
hiddenSize2 = 25;

[features,target] = etl_param(2048,59,dataset,clases);
[Xe,Ye,Xv,Yv] = sort_rows(features,target,clases,trainperc); 

t = grid;
iter = size(t,2);
arrmse = zeros(2,iter);

for i=1:iter
    % entrenamiento primer SAE
    autoenc1 = trainAutoencoder(Xe,hiddenSize1,'MaxEpochs',200,'L2WeightRegularization',t(1,i),'SparsityRegularization',t(2,i),'SparsityProportion',t(3,i),'ShowProgressWindow',false);
    feat1 = encode(autoenc1,Xe); 
    XReconstructed = predict(autoenc1,Xe);
    arrmse(1,i) = mse(Xe-XReconstructed);
    % entrenamiento segudo SAE
    autoenc2 = trainAutoencoder(feat1,hiddenSize2,'MaxEpochs',200,'L2WeightRegularization',t(4,i),'SparsityRegularization',t(5,i),'SparsityProportion',t(6,i),'ShowProgressWindow',false);
    FReconstructed = predict(autoenc2,feat1);
    arrmse(2,i) = mse(feat1-FReconstructed);
end
    