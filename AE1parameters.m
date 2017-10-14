% Parámetros main
dataset = 'E';
clases = 10;
trainperc = 0.7;

% Parámetros de los autoencoder
hiddenSize1 = 102;
hiddenSize2 = 25;

[features,target] = etl_param(2048,59,dataset,clases);
[Xe,Ye,Xv,Yv] = sort_rows(features,target,clases,trainperc); 

t = [0.0162906665906445;96.6491152028911;0.130050141545906;0.00467805401358500;97.8639996678380;0.385538479498422];
%iter = size(t,1);
iter = 10;
arrmse = zeros(1,iter);

for i=1:iter
    autoenc1 = trainAutoencoder(Xe,hiddenSize1,'MaxEpochs',200,'L2WeightRegularization',t(1),'SparsityRegularization',t(2),'SparsityProportion',t(3),'ShowProgressWindow',false);
    XReconstructed = predict(autoenc1,Xe);
    arrmse(i) = mse(Xe-XReconstructed);
end
