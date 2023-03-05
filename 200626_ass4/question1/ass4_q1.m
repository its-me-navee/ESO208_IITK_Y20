%{
How to use the program:
Suppose the function to be evaluated is:
f(x)= -0.0547x^4 +0.8646x^3 -4.1562x^2 +6.2917x +2
to be integrated from 0 to 8 with 0.10% tolerance oor upto 3 iterations

Enter the function to be integrated: 
(-0.0547*x^4)+(0.8646*x^3)-(4.1562*x^2)+(6.2917*x)+2

The lower limit is:0
The upper limit is:8

If tolerance of 0.10%:.*
%}
clc
clearvars
%This is for inputs
fileID = fopen('input_q1.txt','rt');
f = fscanf(fileID,'%s',1);
f = char(f);
f = str2func(['@(x)' f]);  %function to be integrated
inputs = fscanf(fileID,'%f',3);
fclose(fileID);

a= inputs(1); %input('The lower limit is : ')
b= inputs(2); %input('The upper limit is : ')
e= inputs(3); %input('The desired approximate relative error in % is : ')
A=zeros(10,10);

fprintf("Enter the method you want to use\n");
fprintf("1. Romberg Integration\n2. Guass-Legendre quadrature\n");
str = input('');

if str == 1
    %This is the main loop program
    for l=1:100
        r=l;
        n=1;
        I=zeros(l+1,1);

        for j=1:l+1
            h=(b-a)/n;
            X=a;
            fa=0;
            for i=1:n+1
                fX=2*f(X);
                fX=fa+fX;
                fa=fX;
                X=X+h;
            end
            fX=fX-f(a)-f(b);
            I(j,1)=(h*fX)/2;
            A(j,1)=I(j,1);
            n=2^j;
        end

        for k=2:l+1
            if k>2
                r=r-1;
            end

            for m=1:r
                I(m,1)=(((4^(k-1))*(I(m+1,1)))-(I(m,1)))/((4^(k-1))-1);
                A(m,k)=I(m,1);
                g=abs((I(m,1)-I(m+1,1))/I(m,1))*100;
            end
        end

        A=A(1:k,1:k);
        if (g<e)
            break;
        end
    end

    itr = 2^l;
    y = linspace(a,b,itr+1);
    for i=1:itr+1
        funct(i)=feval(f,y(i));
    end
    scatter(y,funct,'black','filled','SizeData',100); 
    hold on; 
    grid on;
    grid minor;
    xlabel('x'); 
    ylabel('y');
    title('Romberg');

    %Interpretation of results
    fileID = fopen('output_romberg.txt','wt');
    fprintf(fileID,'I : %.8f \n',A(1,k));
    fprintf(fileID,'Number of intervals : %.0f \n',itr);
    fprintf(fileID,'Approximate relative error : %.4f \n',g);
end


if str == 2
    iter=0;
    P=[0,1;1,0];
    err =inf;
    h=b-a;
    iter=1;
    last=0;
    Pnew = [P(2,:).*(2-1/2),0] - [0,P(2-1,:).*(1-1/2)];
    P=[zeros(2,1),P;Pnew];
    Z=roots(P(2+1,:));
    z=roots(P(1+2,:));
    m=1;
    W(1)=2*(1-z(1)^2)/((m+1)*polyval(P(m+1,:),z(1)))^2;
    Iz=0;
    z(1)=z(1)*(b-a)/2+(b+a)/2;
    Iz=Iz+f(z(1))*W(1);
    last=(b-a)/2*Iz;


    while err>e
        iter=iter+1;
        n=iter+1;
        Pnew=[P(n,:).*(2 -1/n),0] - [0,P(n-1,:).*(1 -1/n)];
        P=[zeros(n,1),P;Pnew];
        Z=roots(P(n+1,:));
        z=roots(P(iter+2,:));
        m=iter;
        for i=1:n
            W(i)=2*(1-z(i)^2)/((m+1)*polyval(P(m+1,:),z(i)))^2;
        end
        Iz=0;
        for i=1:n
            z(i)=z(i)*(b-a)/2+(b+a)/2;
            Iz=Iz+f(z(i))*W(i);
        end
        Ix=(b-a)/2*Iz;
        err=100*abs(last-Ix)/Ix;
        last=Ix;
    end

    y=z.';
    for i=1:iter+1
        funct(i)=feval(f,y(i));
    end
    scatter(z,funct,'black','filled','SizeData',100); 
    hold on; 
    grid on;
    grid minor;
    xlabel('x'); 
    ylabel('y');
    title('Gauss-Legendre Quadrature');

    fileID = fopen('output_Gauss_Legendre.txt','wt');
    fprintf(fileID,'I : %.8f \n',Ix);
    fprintf(fileID,'Number of intervals : %.0f \n',iter);
    fprintf(fileID,'Approximate relative error : %f \n',err);
    
end