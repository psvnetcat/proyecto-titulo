% Parámetros main
dataset = 'C';
clases = 10;
trainperc = 0.7;

% Parámetros de los autoencoder
hiddenSize1 = 102;
hiddenSize2 = 25;

[features,target] = etl_param(1024,100,dataset,clases);
[Xe,Ye,Xv,Yv] = sort_rows(features,target,clases,trainperc); 

%t = [0.9;0.92;0.93;0.97;1];
%t = [0.02;0.002;0.0002;0.00002];
%t = [0.01;0.05;0.001;0.005;0.0001;0.0005;0.00001];
t = [0.00001;0.00002;0.00004;0.00006;0.00008;0.00009];
iter = size(t,1);
arrmse = zeros(1,iter);

%training del primer autoencoder
autoenc1 = trainAutoencoder(Xe,hiddenSize1,'MaxEpochs',200,'L2WeightRegularization',0.005,'SparsityRegularization',0.97,'SparsityProportion',0.02,'ShowProgressWindow',false);
feat1 = encode(autoenc1,Xe); 
    
for i=1:iter
    autoenc2 = trainAutoencoder(feat1,hiddenSize2,'MaxEpochs',200,'L2WeightRegularization',0.00002,'SparsityRegularization',0.97,'SparsityProportion',0.05,'ShowProgressWindow',false);
    XReconstructed = predict(autoenc2,feat1);
    arrmse(i) = mse(feat1-XReconstructed);
end