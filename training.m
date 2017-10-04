function [deepnet] = training(hiddenSize1,hiddenSize2,Xe,Ye)
    % Pre-training
    autoenc1 = trainAutoencoder(Xe,hiddenSize1,'MaxEpochs',200,'L2WeightRegularization',0.022,'SparsityRegularization',0.97,'SparsityProportion',0.02,'ShowProgressWindow',false);
    feat1 = encode(autoenc1,Xe); 
    autoenc2 = trainAutoencoder(feat1,hiddenSize2,'MaxEpochs',200,'L2WeightRegularization',0.0002,'SparsityRegularization',0.97,'SparsityProportion',0.25,'ShowProgressWindow',false);
    feat2 = encode(autoenc2,feat1);
    softnet = trainSoftmaxLayer(feat2,Ye,'MaxEpochs',400,'ShowProgressWindow',false);
    deepnet = stack(autoenc1,autoenc2,softnet);
    
    % Fine-tunning
    deepnet = train(deepnet,Xe,Ye);
end