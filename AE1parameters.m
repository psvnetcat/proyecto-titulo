% Parámetros main
dataset = 'E';
clases = 10;
trainperc = 0.7;

% Parámetros de los autoencoder
hiddenSize1 = 102;
hiddenSize2 = 25;

[features,target] = etl_param(2048,59,dataset,clases);
[Xe,Ye,Xv,Yv] = sort_rows(features,target,clases,trainperc); 

t = grid(1:3,:);
iter = size(t,2);
arrmse = zeros(1,iter);

for i=1:iter
    autoenc1 = trainAutoencoder(Xe,hiddenSize1,'MaxEpochs',200,'L2WeightRegularization',t(1,i),'SparsityRegularization',t(2,i),'SparsityProportion',t(3,i),'ShowProgressWindow',false);
    XReconstructed = predict(autoenc1,Xe);
    arrmse(i) = mse(Xe-XReconstructed);
end
