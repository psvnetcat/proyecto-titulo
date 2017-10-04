% Parámetros main
dataset = 'C';
clases = 10;
trainperc = 0.7;

% Parámetros de los autoencoder
hiddenSize1 = 102;
hiddenSize2 = 25;

[features,target] = etl_param(1024,100,dataset,clases);
[Xe,Ye,Xv,Yv] = sort_rows(features,target,clases,trainperc); 

t = [0.4;0.2;0.04;0.02;0.004;0.002;0.0004;0.0002;0.00004;0.00002];
iter = size(t,1);
arrmse = zeros(1,iter);

for i=1:iter
    autoenc1 = trainAutoencoder(Xe,hiddenSize1,'MaxEpochs',200,'L2WeightRegularization',0.005,'SparsityRegularization',0.97,'SparsityProportion',t(i),'ShowProgressWindow',false);
    XReconstructed = predict(autoenc1,Xe);
    arrmse(i) = mse(Xe-XReconstructed);
end
