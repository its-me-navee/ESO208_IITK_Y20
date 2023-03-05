method=input("1:Ghost \n2:Backward Diff \n")
xini=0;
Tini=5;
xf=2;
L=2;
x=0:0.5:2;
h=0.5;
a=zeros(5);
b=zeros(5);
f=zeros(5);

for i=1:5
    a(i)=-(x(i)+3)/(x(i)+1);
    b(i)=(x(i)+3)/((x(i)+1)^2);
    f(i)=2*(x(i)+1)+ 3*b(i);
end

d= zeros(3,1);
l= zeros(3,1);
u= zeros(3,1);
g= zeros(3,1);

for i=1:3
    d(i)=b(i+1)-(2/h^2);
    l(i)=(1/h^2)-a(i+2)/(2*h); 
    u(i)=(1/h^2)+a(i+1)/(2*h);
    g(i)=f(i+1);
end

g(1)= g(1)-((1/h^2)-a(2)/(2*h))*Tini;

if(method==1)
    d(3)=d(3)+((1/h^2)+a(4)/(2*h));
end

if(method==2)
    l(3)=(2/(3*h^2))-(2*a(4))/(3*h);
    d(3)=b(4)-(2/(3*h^2))+(2*a(4))/(3*h);
end

%thomas algo
n=3;
A=zeros(1,3);
B=zeros(1,3);
x0=zeros(1,3);
A(1)=d(1);
B(1)=g(1);

for i=2:n
    A(i)=d(i)-((l(i)/A(i-1))*u(i-1));
end

for i=2:n
    B(i)=g(i)-((l(i)/A(i-1))*B(i-1));
end
x0(n)=B(n)/A(n);

for i=n-1:-1:1
    x0(i)=(B(i)-(u(i)*x(i+1)))/A(i);
end

if(method==1)
    T= x0(3);
end

if(method==2)
    T= 4*(x0(3))/3-(x0(2))/3;
end

Tsol=zeros(1,5);
Tsol(1,1)=5;
Tsol(1,5)=T;

for i=2:4
    Tsol(1,i)=x0(i-1);
end

p = figure(1, "visible", "off");
    plot(x , Tsol , 'r-*');
    title('Plot of Temperature T vs Distance x");
    xlabel('Length (x)');
    ylabel('Temperature (T)');
    prutorsaveplot(p, "myplot1.pdf");
