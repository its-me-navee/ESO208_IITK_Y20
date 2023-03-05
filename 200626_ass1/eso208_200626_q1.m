                                   % ESO208 Assignment 1
                                   % NAVNEET SINGH
                                   % 200626
                                   % Q1
% finding roots of a non-linear equation
% Test functions:
% f(x)=x-cos(⁡x)
% Use the initial bracket as (0,1) or the initial guess as 0; maximum iterations 50;
% and maximum εr = 0.01%. For Fixed-Point method, use phi(x)=cos x.

% f(x)=exp(⁡-x)-x
% Use the initial bracket as (0,1) or the initial guess as 0; maximum iterations 50;
% and maximum εr = 0.05%. For Fixed-Point method, use phi(x)=exp(−x).
 
disp('List of methods:');
disp('1. Bisection Method');
disp('2. Regula Falsi');
disp('3. Fixed Point');
disp('4. Newton Raphson');
disp('5. Secant');
method_type=input('Enter method number to use : ');

% plotting the input function

func = input('Enter your function : ','s');
str1 = strcat('@(x)', func);
fn = str2func(str1);
figure;
fplot(fn,'r', 'LineWidth', 2);
grid on;

% 1. Bisection Method
if ( method_type == 1 )
    %syms x;
    %fn = input('Enter the function :  ');
    x_low = input('Enter the Value of x_low :  ');
    x_up= input('Enter the value of x_up :  ');
    max_it = input('Enter the max no. of iterations :  ');
    max_re = input('Enter the max relative error in(%) :  ');
    error = zeros(100);
    error(1) = 100;
    x_mid = zeros(100);
    for i = 1:max_it
        x_mid(i) = ( x_low + x_up )/2;

        if (subs(fn,x_low))*(subs(fn,x_mid(i))) <0
            x_up = x_mid(i);
        end

        if (subs(fn,x_up))*(subs(fn,x_mid(i)))<0
            x_low = x_mid(i);
        end
        if i > 1
            error(i) = abs((x_mid(i) - x_mid(i-1))*100/x_mid(i));
        end
        if  error(i) <= max_re
            disp('error condition reached');
            break;
        end
    end
    if(i>=max_it)
        disp('max iteration reached');
    end
    disp('Root is : ');
    disp(x_mid(i));
    % plotting
    
    b = 2:i-1;
    err_to_plt = error(b);
    figure;
    plot(b,err_to_plt,'bo-', 'LineWidth', 2);
    grid
    title('Bisection Method');
    xlabel('iteration number');
    ylabel('relative error');
    hold off;
end
% 2. Regula Falsi

if(method_type == 2)

    x_low = input('Enter the first guess : ');
    x_up = input('Enter the second guess :  ');
    max_it = input('Enter the max no. of iterations :  ');
    max_re = input('Enter the max error(%) :  ');
    y = zeros(100);
    error = zeros(100);
    y(1) = x_low - (subs(fn,x_low))*(x_up-x_low)/(subs(fn,x_up) - subs(fn,x_low));

    % fix one point yl
    if (subs(fn,y(1))*subs(fn,x_up)) < 0
        x_low = x_up;
    end

    for i = 1:max_it
        y(i+1) = x_low - (subs(fn,x_low))*(x_low-y(i))/(subs(fn,x_low) - subs(fn,y(i)));
        error(i) = abs((y(i+1) - y(i))*100/y(i+1));
        if error(i) <= max_re
            disp('Error condition reached');
            break;
        end
    end
    if i>=max_it
        disp('max iterations reached');
    end
    disp('Root is : ');
    disp(y(i+1));

    % plotting
    a = 1+1:i;
    b = error(a);
    figure;
    plot(a,b,'bo-', 'LineWidth', 2);
    grid on
    title('Regula Falsi');
    xlabel('iteration');
    ylabel('Absolute relative error ');
end

% 3. Fixed Point

if(method_type == 3)

    x_new = zeros(100);
    x_new(1) = input('Enter the Inital Guess :  ');
    max_it = input('Enter the maximum number of iterations :  ');
    max_re = input('Enter the max error in (%) :  ');
    error = zeros(100);
    for i = 1:max_it
        x_new(i+1) = subs(fn,x_new(i));
        error(i) = abs(( x_new(i+1)-x_new(i) )*100/x_new(i+1));
        if error(i) <= max_re
            disp('error condition reached');
            break;
        end
        if i>=max_it
            disp('max iterations reached');
        end
    end
    disp('Root is : ');
    disp(x_new(i+1));


    % plotting
    b = 1:i;
    err_to_plt = error(b);
    figure;
    plot(b,err_to_plt,'bo-', 'LineWidth', 2);
    grid on
    title('Fixed Point');
    xlabel('iteration');
    ylabel('relative error');

    
end
% 4. Newton Raphson
if(method_type == 4)

    syms x;
    g = input('Enter the derivative function :  ');
    x_new(1) = input('Enter the initial point :  ');
    max_it = input('Enter the max no. of iterations :  ');
    max_re = input('Enter the max error in (%) :  ');
    error = zeros(100);
    for i = 1:1:max_it
        a = subs(fn,x_new(i));
        b = subs(g,x_new(i));
        c  = a/b;
        x_new(i+1) = x_new(i)-c;

        error(i) = abs(( x_new(i+1)-x_new(i))/x_new(i+1))*100;
        if (error(i) <= max_re)
            disp('error condition reached');
            break;
        end
        if(i>=max_it)
            disp('max iterations reached');
        end
    end

    disp('Root is : ');
    disp(x_new(i+1));
    % plotting
    b = 1:i;
    err_to_plt = error(b);
    figure;
    plot(b,err_to_plt,'bo-', 'LineWidth', 2);
    grid on
    title('Newton Raphson');
    xlabel('iteration');
    ylabel('error');
    
end
% 5. Secant method
if(method_type == 5)
   
    x_low = input('Enter the first guess : ');
    x_up = input('Enter the second guess :  ');
    max_it = input('Enter the max no. of iterations :  ');
    max_re = input('Enter the max relative error in (%) :  ');
    x_new = zeros(100);
    error = zeros(100);
    x_new(1) = x_low - (subs(fn,x_low))*(x_up-x_low)/(subs(fn,x_up) - subs(fn,x_low));

    if (subs(fn,x_new(1))*subs(fn,x_up)) < 0
        x_low = x_up;
    end
    for i = 1:max_it

        k = subs(fn,x_low);
        l = subs(fn,x_new(i));
        x_new(i+1) = x_low - (k)*(x_low-x_new(i))/((k) - l);
        error(i) = abs((x_new(i+1) - x_new(i))*100/x_new(i+1));
        if error(i) <= max_re
            disp('error condition reached');
            break;
        end
    end
    if(i>=max_it)
        disp('max iterations reached');
    end
    disp('Root is : ');
    disp(x_new(i+1));
    % plotting
    b = 1+1:i;
    err_to_plt = error(b);
    figure;
    plot(b,err_to_plt,'bo-', 'LineWidth', 2);
    grid on
    title('Secant method');
    xlabel('iteration');
    ylabel('absolute relative error ');

end