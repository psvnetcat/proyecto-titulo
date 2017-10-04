function [energy] = f_norm(signal)
    columns = size(signal,2);
    components = fft(signal,columns,2);
    pruned = components(:,1:(columns/2)); %recorte por simetría de los coeficientes
    energy = abs(pruned).^2; %energía de los componentes de frecuencia
    
    %maxP = max(pruned);
    %normalized = bsxfun(@rdivide,pruned,maxP); % normalización
end