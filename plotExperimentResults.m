
[exgA,excA,fscA] = load_pkg('rsltAnewParam');
[exgB,excB,fscB] = load_pkg('rsltBnewParam');
[exgC,excC,fscC] = load_pkg('rsltCnewParam');
[exgD,excD,fscD] = load_pkg('rsltDnewParam');
[exgE,excE,fscE] = load_pkg('rsltEnewParam');
iter = size(exgA,2);

mediaA = mean(excA,1);
mediaB = mean(excB,1);
mediaC = mean(excC,1);
mediaD = mean(excD,1);
mediaE = mean(excE,1);

mFscA = mean(fscA,1);
mFscB = mean(fscB,1);
mFscC = mean(fscC,1);
mFscD = mean(fscD,1);
mFscE = mean(fscE,1);

nFscA = mean(fscA,2);
nFscB = mean(fscB,2);
nFscC = mean(fscC,2);
nFscD = mean(fscD,2);
nFscE = mean(fscE,2);

figure(1)
plot(1:iter,exgE,'-o');
legend('testing')
legend('Location','southwest')
legend('boxoff')
ylim([99.5 100])
xlabel('Trial number')
ylabel('Accuracy (%)')
title('E')

%{     
plot(1:iter,exgA,'-o',1:iter,exgB,'-s',1:iter,exgC,'-d',1:iter,exgD,'-v',1:iter,exgE,'-*');
legend('A','B','C','D','E')
legend('Location','southwest')
legend('boxoff')
ylim([98 100])
grid on
xlabel('Número de ejecución')
ylabel('Exactitud (%)')
title('Exactitud por ejecución')
%}

%{
plot(1:10,100*mediaA,'-o',1:10,100*mediaB,'-s',1:10,100*mediaC,'-d',1:10,100*mediaD,'-v',1:10,100*mediaE,'-*');
legend('A','B','C','D','E')
legend('Location','southwest')
legend('boxoff')
ylim([99.8 100])
grid on
xlabel('Etiquetas')
ylabel('Exactitud media (%)')
title('Exactitud por etiqueta')
%}

%{
plot(1:10,100*mFscA,'-o',1:10,100*mFscB,'-s',1:10,100*mFscC,'-d',1:10,100*mFscD,'-v',1:10,100*mFscE,'-*');
legend('A','B','C','D','E')
legend('Location','southwest')
legend('boxoff')
ylim([99 100])
grid on
xlabel('Etiquetas')
ylabel('F-score promedio (%)')
title('F-score por etiqueta')
%}

%{
plot(1:30,100*nFscA,'-o',1:30,100*nFscB,'-s',1:30,100*nFscC,'-d',1:30,100*nFscD,'-v',1:30,100*nFscE,'-*');
legend('A','B','C','D','E')
legend('Location','southwest')
legend('boxoff')
ylim([98 100])
grid on
xlabel('Número de ejecución')
ylabel('F-score promedio (%)')
title('F-score medio por ejecución')
%}