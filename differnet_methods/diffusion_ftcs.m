n = 10; %(’number of points? ’)
h = 1.0/n;
dt = 0.5*h^2;
%
% Index shift since Matlab doesn’t allow zero subscripts
%
np = n+1;
x = h*[0:n];
uo = sin(pi*x);
nt = floor(0.1/dt);
phi(:,:)=zeros;
r = dt/(h*h);
for k=1:nt
    t(k) = k*dt;
    u(1) = 0;
    ue(1) = 0;
        for j=2:n
            u(j) = uo(j) + r*(uo(j-1) - 2*uo(j) + uo(j+1));
            ue(j) = exp(-pi*pi*t(k))*sin(pi*(j-1)*h);
            error(j) = ue(j) - u(j);
        end
    u(np) = 0;
    ue(np) = 0;
    uo = u;
     errmax(k) = norm(error,inf);
    phi(k,1:np)=u; %2D array for function plotting
end
p1 = figure(1,"visible", "on");
plot(x,u,x,ue,'-r')
%prutorsaveplot(p1, "myplot1.pdf");

p2 = figure(2,"visible", "on");
plot(t,errmax,'-g')
%prutorsaveplot(p2, "myplot2.pdf");

p3 = figure(3,"visible", "on");
surf(x,t,phi)
%prutorsaveplot(p3, "myplot3.pdf");
