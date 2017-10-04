function [signal,target] = signal_load(large,samples,type,dataset,labels)
    switch dataset
        case 'A'
            cd 'A';
        case 'B'
            cd 'B';
        case 'C'
            cd 'C';
        case 'D'
            cd 'D';
        case 'E'
            cd 'E';
    end

    % Carga de las señales
    switch type
        case 'ball0007'
            cd 'b1';
        case 'ball0014'
            cd 'b2';
        case 'ball0021'
            cd 'b3';
        case 'inner0007'
            cd 'i1';
        case 'inner0014'
            cd 'i2';
        case 'inner0021'
            cd 'i3';
        case 'outer0007'
            cd 'o1';
        case 'outer0014'
            cd 'o2';
        case 'outer0021'
            cd 'o3';
        case 'normal'
            cd 'n';
    end

    % carga de las señales
    files = ls('*.mat'); 
    cellFiles = cellstr(files);

    for i=1:length(cellFiles)
        load(cellFiles{i,1});
    end

    vars = who('*DE_time');
    signal = [];
    for i=1:length(vars)
        tmp = eval(vars{i,1});
        signal = vertcat(vec2mat(tmp(1:large*samples),large),signal);
    end

    target = zeros(size(signal,1),labels);

    switch type
        case 'ball0007'
            target(:,1) = 1;
        case 'ball0014'
            target(:,2) = 1;
        case 'ball0021'
            target(:,3) = 1;
        case 'inner0007'
            target(:,4) = 1;
        case 'inner0014'
            target(:,5) = 1;
        case 'inner0021'
            target(:,6) = 1;
        case 'outer0007'
            target(:,7) = 1;
        case 'outer0014'
            target(:,8) = 1;
        case 'outer0021'
            target(:,9) = 1;
        case 'normal'
            target(:,10) = 1;
    end

    cd '../../'
end