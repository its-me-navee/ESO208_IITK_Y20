L = 4;
a = 0.0;    %left boundary coordinate
b = L;      %right boundary coordinate
h = 0.1;    %length discritization
u1 = 0.0;   %initial condition of ODE1 same as the left boundary condition
v11 = 0.0;  %1st guess initial condition of ODE2
v12 = 2.0;  %2nd gyess initial condition of ODE2
y1 = 0.0;   %right bounday condition to be used for tolerance
tol = 0.0001;
imax = 15;  %maximum number of iteration.

function dudx = ODEu(x,u,v)
    dudx = v;
endfunction;

function dvdx = ODEv(x,u,v)
    L = 4;
    EI = 1.4e7;
    q = 10e3;
    dvdx = ((1.+v.^2)^(3./2)*1./2*q*(L*x-x.^2))/EI;
endfunction; 

function [x, u, v] = Sys2ODEsRK2(ODE1,ODE2,a,b,h,uINI,vINI)
x(1) = a; u(1) = uINI; v(1) = vINI;
N = (b - a)/h;
for i = 1:N
    x(i + 1) = x(i) + h;
    Ku1 = ODE1(x(i), u(i), v(i));
    Kv1 = ODE2(x(i), u(i), v(i)) ;
    Ku2=ODE1(x(i+1),u(i)+Ku1*h,v(i)+Kv1*h);
    Kv2=ODE2(x(i+1),u(i)+Ku1*h,v(i)+Kv1*h);
    u(i+1)=u(i)+(Ku1+Ku2)*h/2;
    v(i+1)=v(i)+(Kv1+Kv2)*h/2;
end
endfunction;

[x, u, v] = Sys2ODEsRK2(@ODEu,@ODEv,a,b,h,u1,v11);
n = length(x);
u_old = u(n);
[x, u, v] = Sys2ODEsRK2(@ODEu,@ODEv,a,b,h,u1,v12);


%Secant Method
for i = 1:imax+2
    vi = v(1) - (u(n)-y1)*(v(1)-v11)/(u(n)-u_old);

    Err = abs(y1-u(n));
    if Err<tol
        break
    end
    v11 = v(1);
    u_old = u(n);
    [x, u, v] = Sys2ODEsRK2(@ODEu,@ODEv,a,b,h,u1,vi);
end


if i > imax
    fprintf("Solution was not obtained in %i. iterations.",imax)
else
    p = figure(1, "visible", "off");
    plot(x,u);
    title('Plot of beam deflection');
    xlabel('Length (m)');
    ylabel('Deflection (m)');
    prutorsaveplot(p, "myplot1.pdf");
end
 