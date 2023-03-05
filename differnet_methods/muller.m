 x0=input("Enter x0");
 x1=input("Enter x1");
 x2=input("Enter x2");
 str=input("Enter function:",'s');
 f=inline(str,'x');
 er=10000;
 
 while er>0
    f0=feval(f,x0);
    f1=feval(f,x1);
    f2=feval(f,x2);
    h0=x1-x0;
    h1=x2-x1;
    d0=(f1-f0)/(x1-x0);
    d1=(f2-f1)/(x2-x1);
    a=(d1-d0)/(h1+h0);
    b=a*h1+d1;
    c=f2;
    
    D=(b^2-4*a*c)^0.5;
    if(b<0) D=D*-1; end;
    x3=x2-2*c/(b+D);
    er=abs((x3-x2)/x3)*100;
    x0=x1;
    x1=x2;
    x2=x3;
 end
 
 fprintf("\nYour root is: ");
 disp(x2);