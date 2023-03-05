a=1.0;
b=2.0;
e = 0.1 ;
fa = a^4*sin(a) - exp(a);
fb = b^4*sin(b) - exp(b);
i=0;
x = b - fb*(b-a)/(fb-fa) ;
ea = abs(x-b)*100/x;
fprintf('\n\na\t\tb\t\tfa\t\tfb\t\tx\t\tea\n\n');

while abs(ea)>e && i<10
    fprintf('%f\t%f\t%f\t%f\t%f\t%f\n',a,b,fa,fb,x,ea);
    a=b;
    b=x;
    fa = a^4*sin(a) - exp(a);
    fb = b^4*sin(b) - exp(b);
    x=b - fb*(b-a)/(fb-fa) ;
    ea = abs(x-b)*100/x;
    i = i+1;
end
 fprintf('%f\t%f\t%f\t%f\t%f\t%f\n',a,b,fa,fb,x,ea);