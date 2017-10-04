function [signal,target] = etl_param(large,samples,dataset,labels)

    [signal1,target1] = signal_load(large,samples,'ball0007',dataset,labels);
    [signal2,target2] = signal_load(large,samples,'ball0014',dataset,labels);
    [signal3,target3] = signal_load(large,samples,'ball0021',dataset,labels);
    [signal4,target4] = signal_load(large,samples,'inner0007',dataset,labels);
    [signal5,target5] = signal_load(large,samples,'inner0014',dataset,labels);
    [signal6,target6] = signal_load(large,samples,'inner0021',dataset,labels);
    [signal7,target7] = signal_load(large,samples,'outer0007',dataset,labels);
    [signal8,target8] = signal_load(large,samples,'outer0014',dataset,labels);
    [signal9,target9] = signal_load(large,samples,'outer0021',dataset,labels);
    [signal10,target10] = signal_load(large,samples,'normal',dataset,labels);

    % Concatenacion de matrices 
    signal = [f_norm(signal1);f_norm(signal2);f_norm(signal3);f_norm(signal4);f_norm(signal5);f_norm(signal6);f_norm(signal7);f_norm(signal8);f_norm(signal9);f_norm(signal10)];
    target = [target1;target2;target3;target4;target5;target6;target7;target8;target9;target10];
end