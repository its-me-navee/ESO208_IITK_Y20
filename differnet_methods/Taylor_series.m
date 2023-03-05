n=input("degree (<=10)= ")
coef=input("coefficient = ")
val=input("base value = ")
x=input("x for which function to be determined = ")
y0=flip(coef);
h=x-val;
sol=polyval(y0,x);
f0=polyval(y0,val)
fprintf("Function at base value ans = %d",f0);
fprintf("True solution ans = %d",sol);
fprintf("Zeroth order approximation f0 = %d",f0);
error=abs(sol-f0)*100/sol

y1=polyder(y0);
f1=f0+polyval(y1,val)*h
y2=polyder(y1);
f2=f1+polyval(y2,val)*(h^2)/2
y3=polyder(y2);
f3=f2+polyval(y3,val)*(h^3)/6
