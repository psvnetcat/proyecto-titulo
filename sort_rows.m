function [Xe,Ye,Xv,Yv] = sort_rows(features,target,clases,trainperc)
    % Re-ordenamiento de la señal y el target
    rows = size(features,1);
    columns = size(features,2);
    randvec = randperm(rows); % array de valores aleatorios

    targetR = zeros(rows,clases); % 4 o 10 clases
    Xr = zeros(rows,columns);

    for i=1:rows
        Xr(i,:) = features(randvec(i),:);
        targetR(i,:) = target(randvec(i),:);
    end

    rows = size(Xr,1);
    limite = floor(trainperc*rows);

    % Data training
    Xe = Xr(1:limite,:)';
    Ye = targetR(1:limite,:)';

    % Data test
    Xv = Xr(limite+1:end,:)';
    Yv = targetR(limite+1:end,:)';
end