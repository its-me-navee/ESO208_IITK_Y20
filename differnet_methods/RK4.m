
a=0;
b=1;
yINI=3;
zINI=0.2;
h=0.1;



function [x, y, z] = Sys2ODEsRK4(ODE1,ODE2,a,b,h,yINI,zINI)
% Sys2ODEsRK2 solves a system of two first-order initial value ODEs using
% second-order Runge-Kutta method.
% The independent variable is x, and the dependent variables are y and z.
% Input variables:
% ODEl Name for the function that calculates dy/dx.
% ODE2 Name for the function that calculates dz/dx.
% a The first value of x.
% b The last value of x.
% h The size of a increment.
% yINI The initial value of y.
% zINI The initial value of z.
% Output variables:
% x A vector with the x coordinate of the solution points.
% y A vector with the y coordinate of the solution points.
% z A vector with the z coordinate of the solution points.

x(1) = a; y(1) = yINI; z(1) = zINI;
N = (b - a)/h;
for i = 1:N
    
    x(i + 1) = x(i) + h;
    Ky1 = ODE1(x(i), y(i), z(i));
    Kz1 = ODE2(x(i), y(i), z(i)) ;
    Ky2=ODE1(x(i)+h/2,y(i)+Ky1*h/2,z(i)+Kz1*h/2);
    Kz2=ODE2(x(i)+h/2,y(i)+Ky1*h/2,z(i)+Kz1*h/2);
    Ky3=ODE1(x(i)+h/2,y(i)+Ky2*h/2,z(i)+Kz2*h/2);
    Kz3=ODE2(x(i)+h/2,y(i)+Ky2*h/2,z(i)+Kz2*h/2);
    Ky4=ODE1(x(i+1),y(i)+Ky3*h,z(i)+Kz3*h);
    Kz4=ODE2(x(i+1),y(i)+Ky3*h,z(i)+Kz3*h);
    y(i+1)=y(i)+(Ky1+2*Ky2+2*Ky3+Ky4)*h/6;
    z(i+1)=z(i)+(Kz1+2*Kz2+2*Kz3+Kz4)*h/6;
end
endfunction;



function dydt = ODE1(x,y,z)
    dydt = y-z^2;
endfunction;

function dzdt = ODE2(x,y,z)
    dzdt = (z-y)*exp(1-x)+0.5*y;
endfunction;

[x, y, z]= Sys2ODEsRK4(@ODE1,@ODE2,a,b,h,yINI,zINI)

    p=figure(1, "visible", "on");
    plot(x,y,x,z)
    hold on;
    %plot(x,z);
    title('Plot of y and z vs t');
    xlabel('Time (t)');
    ylabel('y/z');
    %prutorsaveplot(p, "myplot1.pdf");




