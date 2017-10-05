function [deepnet] = training(hiddenSize1,hiddenSize2,Xe,Ye,wd1,sr1,sp1,wd2,sr2,sp2)
    % Pre-training
    autoenc1 = trainAutoencoder(Xe,hiddenSize1,'MaxEpochs',200,'L2WeightRegularization',wd1,'SparsityRegularization',sr1,'SparsityProportion',sp1,'ShowProgressWindow',false);
    feat1 = encode(autoenc1,Xe); 
    autoenc2 = trainAutoencoder(feat1,hiddenSize2,'MaxEpochs',200,'L2WeightRegularization',wd2,'SparsityRegularization',sr2,'SparsityProportion',sp2,'ShowProgressWindow',false);
    feat2 = encode(autoenc2,feat1);
    softnet = trainSoftmaxLayer(feat2,Ye,'MaxEpochs',400,'ShowProgressWindow',false);
    deepnet = stack(autoenc1,autoenc2,softnet);
    
    % Fine-tunning
    deepnet = train(deepnet,Xe,Ye);
end