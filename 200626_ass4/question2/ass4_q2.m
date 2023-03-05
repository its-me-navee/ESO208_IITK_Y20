clc
clearvars
% func = input('Enter the function (dy/dx)\n','s');
% func = char(func);
% file = input('Enter name of file to run\n','s');
%file = char(file);
fileID = fopen('input_q2.txt','rt');
func = fscanf(fileID,'%s',1);
func = char(func);
f = inline(func,'x','y');
inputs = fscanf(fileID,'%f',4);
fclose(fileID);

x0 = inputs(1);
y0 = inputs(2);
xf = inputs(3);
h = inputs(4);

n = (xf-x0)/h;
x = zeros(n,1);
y = zeros(n,1);
x(1) = x0;
y(1) = y0;

prompt = ('Enter the option to solve ODE\n 1. Euler Forward method\n 2. 2nd order RK method\n 3. 4th order RK method\n');
%y=zeros(xf-x0+1);
str = input(prompt,'s');

%Euler Forward
if strcmp(str, '1')
    for i = 2:n+1
        x(i) = x(i-1)+h;
        y(i) = y(i-1)+h*f(x(i-1),y(i-1));
    end

    %k = plot(x,y,'ro');
    k= scatter(x,y,'black','filled','SizeData',100);
    title('y vs x');
    xlabel('x');
    ylabel('y');
    legend(k,'Euler Forward Method');
    grid on;
    grid minor;
    hold on;
    fID = fopen('output_euler-forward.txt','wt');
    fprintf(fID,'x                 y\n');
    for i = 1:n+1
        fprintf(fID,'%.8f     %.8f\n',x(i),y(i));
    end

end

%2nd order Runge Kutta
if strcmp(str, '2')
    for i = 2:n+1
        x(i) = x(i-1)+h;
        phi0 = f(x(i-1),y(i-1));
        phi1 = f(x(i-1)+ h,y(i-1)+ h*phi0);

        y(i) = y(i-1)+h*(phi0+phi1)/2;
    end
    k= scatter(x,y,'black','filled','SizeData',100);
    title('y vs x');
    xlabel('x');
    ylabel('y');
    legend(k,'2nd order RK');
    grid on;
    grid minor;
    hold on;
    fID = fopen('output_2nd_order_RK.txt','wt');
    fprintf(fID,'x                 y\n');
    for i = 1:n+1
        fprintf(fID,'%.8f     %.8f\n',x(i),y(i));
    end
end

%4th order Runge Kutta
if strcmp(str, '3')
    for i = 2:n+1
        x(i) = x(i-1)+h;
        phi0 = f(x(i-1),y(i-1));
        phi1 = f(x(i-1)+0.5*h,y(i-1)+0.5*h*phi0);
        phi2 = f(x(i-1)+0.5*h,y(i-1)+0.5*h*phi1);
        phi3 = f(x(i-1)+h,y(i-1)+h*phi2);
        y(i) = y(i-1)+h*(phi0/6+(phi1+phi2)/3+phi3/6);
    end
    k= scatter(x,y,'black','filled','SizeData',100);
    title('y vs x');
    xlabel('x');
    ylabel('y');
    legend(k,'4th order RK');
    grid on;
    grid minor;
    hold on;
    fID = fopen('output_4th_order_RK.txt','wt');
    fprintf(fID,'x                 y\n');
    for i = 1:n+1
        fprintf(fID,'%.8f     %.8f\n',x(i),y(i));
    end
end