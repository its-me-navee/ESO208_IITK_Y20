#{
%%%%%%%%%%%%%%%%%%% INSTRUCTIONS FOR USE %%%%%%%%%%%%%%%%%%%%%%
Step 1: Sort (x,y) point pairs in ascending order of "x"
Step 2: Create two separate columns of x value and y values
Step 3: Give sample input as given below
Step 4: Expect output as given

%%%%%%%%%%%%%%%%%%%%%%%% INPUT SYNTAX %%%%%%%%%%%%%%%%%%%%%%%%%%%
Line 1: Enter ascending x values as a column i.e.';' after each value
Line 2: Enter corresponding y values as per x given above in a column
Line 3: Enter Method of Choice( N for natural and K for KnotaNot spline)
Line 4: Enter x for which interpolated function is to be calculated

%%%%%%%%%%%%%%%%%%%%%%%% SAMPLE INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% For natural spline %%%%%
[0 ; 8 ; 16 ;  24 ;  32 ;  40]
[14.621 ; 11.843 ; 9.870 ; 8.418 ; 7.305 ; 6.413]
N
27
%%%% For Knot a not Spline %%%%%
[0 ; 8 ; 16 ;  24 ;  32 ;  40]
[14.621 ; 11.843 ; 9.870 ; 8.418 ; 7.305 ; 6.413]
K
27
%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT SYNTAX %%%%%%%%%%%%%%%%%%%%%%%%%%
INPUT (as given by user)
Ai
Bi
Ci
Di
The interpolated value is:
Plot generated at 

%%%%%%%%%%%%%%%%%%%%%%%%%%%% NOTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
1]Remember to put semicolons (';') between values in x and y
2]The method input should b strictly in capital letters
2]If interpolated value is not between the range of xmin and xmax, it       will throw an error.
%%%%%%%%%%%%%%%%%%%%%%%%%%%% GRAPH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 How to interpret the graph:
 The black dots represent the original (x,y) pairs given by the user. The  Green lines are the interpolated functions.
 Please scroll to the very bottom for graphs.

#}

%%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE STARTS HERE %%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%% INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%
     X=input("Enter x values as an array of numbers in ascending:")
     Y=input("\nEnter y values as an array of numbers as per x values to make a pair:")
     Method=input("\nPress N for natural spline and press K for not-a-knot spline:",'s')
     x=input("\n Enter x for which interpolated function value is to be computed: ")
    
    n=length(X);
%%%%%%%% CORNER CASE FOR OUTPUT 4 %%%%%%%%    
    if((x<X(1,1)) || (x>X(n,1))) 
        fprintf("The interpolating value is outside the data range,Try again");
        return;
    end
%%%%%%%% CALCULATE DIVIDED DIFFERENCES %%%%%%%%   
    h= zeros(n-1,1);
    for i=1:n-1
        h(i,1)=X(i+1,1)-X(i,1);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%% NATURAL SPLINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    if(Method=='N')
        M= zeros(n,n);
        M(1,1)=0;
        M(n,n)=0;
        
        b=zeros(n,1);
        f=zeros(n,1);
        
        for i=2:n
            f(i,1) = (Y(i,1)-Y(i-1,1))/h(i-1,1);
        end
        for i=2:n-1
            b(i,1) = 6*(f(i+1,1)-f(i,1));
        end    
     
    %%%%%%%% setting M matrix using h %%%%%%%%   
        for i=2:n-1
            M(i,i-1)=h(i-1,1);
            M(i,i)=2*(h(i-1,1)+h(i,1));
            M(i,i+1)=h(i,1);
        end
        
    %%%%%%%% Thomas Algorithm to solve Mv=b %%%%%%%%
        
        l=zeros(n-2,1);
        d=zeros(n-2,1);
        u=zeros(n-2,1);
        for i=2:n-1
            if(i>1) l(i-1,1) = M(i,i-1); end;
            d(i-1,1) = M(i,i);
            if(i<n) u(i-1,1) = M(i,i+1); end;
        end
        
        A=zeros(1,n-2); % in textual language this is alpha
        B=zeros(1,n-2); % in textual language this is beta
        v=zeros(1,n);
        A(1)=d(1);  
        B(1)=b(1);
        m=length(l);
        
        for i=2:m
            A(1,i)=d(i,1)-((l(i,1)/A(1,i-1))*u(i-1,1));
        end
        
        for i=2:m
            B(i)=b(i)-((l(i)/A(i-1))*B(i-1));
        end
        
        v(n-1)=B(m)/A(m);
        
        for i=m-1:-1:1
            v(i+1)=(B(i)-(u(i)*v(i+2)))/A(i);
        end
    
    else
%%%%%%%%%%%%%%%%%%%%%%%%%%% KNOT A NOT SPLINE%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%% setting M,b matrix using h  %%%%%%   
        b=zeros(n,1);
        f=zeros(n,1);
        M= zeros(n,n);
        
        for i=2:n
            f(i,1) = (Y(i,1)-Y(i-1,1))/h(i-1,1);
        end
        for i=2:n-1
            b(i,1) = 6*(f(i+1,1)-f(i,1));
        end    
     
        M(1,1)=h(2,1);
        M(1,2)=-(h(1,1)+h(2,1));
        M(1,3)=h(1,1);
        M(n,n-2)=h(n-1,1);
        M(n,n-1)=-(h(n-1,1)+h(n-2,1));
        M(n,n)=h(n-2,1);

        for i=2:n-1
            M(i,i-1)=h(i-1,1);
            M(i,i)=2*(h(i-1,1)+h(i,1));
            M(i,i+1)=h(i,1);
        end
        
        L= inv(M);
        v=L*b;
    end
    
%%%%%%%%%%%%%%%%%%%%%% EVALUATION OF COEFFICIENTS %%%%%%%%%%%%%%%%%%%%%%%    
    Ai=zeros(n-1,1);
    Bi=zeros(n-1,1);
    Ci=zeros(n-1,1);
    Di=zeros(n-1,1);
    for i=1:n-1
        Ai(i,1)=v(i+1)/(6*h(i,1));
        Bi(i,1)=v(i)/(6*h(i,1));
        Ci(i,1)=(Y(i+1,1)/h(i,1))-(v(i+1)*h(i,1)/6);
        Di(i,1)=(Y(i,1)/h(i,1))-(v(i)*h(i,1)/6);
    end
%%%%%%%%%%%%%%%%%%%%%%%% Output 1 %%%%%%%%%%%%%%%%%%%%%%%%  
    Ai
    Bi
    Ci
    Di
%%%%%%%%%%%%%%%%%%%%%%%% Output 2 %%%%%%%%%%%%%%%%%%%%%%%% 
    for idx=1:n
       if(X(idx,1)>x)
        break;
       end
    end
    
    i=idx-1;
    
    yi=Ai(i,1)*((x-X(i,1))^3)-Bi(i,1)*((x-X(i+1,1))^3)+Ci(i,1)*(x-X(i,1))-Di(i,1)*(x-X(i+1,1));
    
    fprintf("The interpolated value is :");
    disp(yi);
 
%%%%%%%%%%%%%%%%%%%%%%%% Output 3 %%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% PLOTTING GRAPHS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = figure(1, "visible", "off");
    scatter(X,Y,150,'k', "filled");
    hold on;
    for i=1:n-1
        x1=X(i,1):0.001:X(i+1,1);
        y1=Ai(i,1).*((x1-X(i,1)).^3)-Bi(i,1).*((x1-X(i+1,1)).^3)+Ci(i,1).*(x1-X(i,1))-Di(i,1).*(x1-X(i+1,1));
        k=plot(x1,y1,'g');
    end
    title('Plot of interpolated function and function values');
    legend(k,'Fitted Cubic Spline');
    xlabel('x');
    ylabel('y');
    prutorsaveplot(p, "Cubic_spline.pdf");

