
figure(5);hold on
plot(tNMPC,statesNMPC(:,5)*100,'-b');
plot(tNMPC,statesNMPC(:,6)*100,'-r');
plot(tNMPC,statesNMPC(:,7)*100,'-y');
plot(tNMPC,statesNMPC(:,8)*100,'-c');
plot(tNMPC,statesNMPC(:,9)*100,'-k');
plot(tNMPC,statesNMPC(:,10)*100,'-g');
grid on
legend('u1','u2','u3','u4','u5','u6')