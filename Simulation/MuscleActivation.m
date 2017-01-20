function da=MuscleActivation(a,u)
t2=1/0.05;
t1=1/0.015-t2;
da=(u-a).*(t1*u+t2);