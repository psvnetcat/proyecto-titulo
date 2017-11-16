%{
figure(1)
plot(1:10,AccG(1,:));
xlabel('Trial number')
ylim([97 100])
grid on
box off
ylabel('Accuracy (%)')
title('E')
%}
%{
figure(2)
plot(1:10,arrmse,'-o');
xlabel('Trial number')
ylabel('MSE')
title('E')

figure(3)
plot(1:10,grid(3,:),'-o');
xlabel('Trial number')
ylabel('MSE')
title('E')
%}
figure(3)
plot(1:10,mag2db(arrmse(1,:)))
xlabel('Sparsity proportion')
grid on
box off
ylabel('MSE (dB)')