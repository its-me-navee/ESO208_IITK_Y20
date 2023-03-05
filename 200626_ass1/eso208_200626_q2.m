                                   % ESO208 Assignment 1
                                   % NAVNEET SINGH
                                   % 200626
                                   % Q2
% finding roots of a polynomial
% Test Polynomial
% x.^4-7.4*x.^3+20.44*x.^2-24.184*x+9.6448
% Muller method: Start with (−1,0,1) and then (0,1,2)
% Bairstow method: Start with (α0 = −5, α1 = 4) and then (α0 = −2, α1=2)
% Maximum iteration: 50
% Maximum relative approximate error: 0.01%

disp('List of methods:');
disp('1. Mullers method');
disp('2. Bairstows method');
method_type = input('Enter method number to use : ');

% plotting the input function

func = input('Enter your function : ','s');
str1 = strcat('@(x)', func);
fn = str2func(str1);
figure;
fplot(fn,'r', 'LineWidth', 2);
grid on;

% 1. Mullers method
if (method_type == 1)
    syms x;
    y = zeros(100);
    %fn = input('Enter the function : ');
    y(1) = input('Enter the first guess :  ');
    y(2) = input('Enter the second guess :  ');
    y(3) = input('Enter the Third guess :  ');
    max_it = input('Enter the maximum number of iteration :  ');
    max_re = input('Enter the max relative error (%):  ');
    error = zeros(100);
    for i = 3:max_it+2   
       k = subs(fn,y(i)); % subs used to substitue variable value in the function
       l = subs(fn,y(i-1));
       m = subs(fn,y(i-2));
       a = (((k - l )/( y(i) - y(i-1) )) - (l - m)/( y(i-1) - y(i-2) ))/( y(i) - y(i-2));
       b = ( k - l )/( y(i) - y(i-1) ) + a*( y(i) - y(i-1) );
       c = k;
      
       delta_1 = -2*c/( b + sqrt( b*b - 4*a*c )); 
       delta_2 = -2*c/( b - sqrt( b*b - 4*a*c ));
         p = abs(delta_1);
         q = abs(delta_2);
       if p<q
           y(i+1) = y(i) + delta_1;
       end
       if q<p
           y(i+1) = y(i) + delta_2;
       end

       error(i) = abs(( y(i+1)-y(i) )*100/y(i+1));
       if error(i) <= max_re
           disp('error condition reached');
            break;
       end
       if(i >= max_it)
            disp('max iterations reached');
            break;
       end
    end
  disp('Root is : ');
  disp(y(i+1));
end 

% 2. Bairstows method
if (method_type == 2) 
    syms x;
    %syms err1(i);
    %syms err2(i);
    err1 = zeros(100);
    err2 = zeros(100);
    fn = input('Again enter the Test function this time to use power use only " ^ " :  ');
    c = coeffs(fn);
    n = length(c);
    d = zeros(n);
    del = zeros(n-1);
    r = input('Enter the value of r :  ');
    s = input('Enter the valuse of s :  ');
    err_r = 0;
    err_s = 0;
    max_ite = input('Enter the Number of maximum iterations :  ');
    max_re = input('Enter the max relative error limit :  ');
    error = 0;
    for i = 1:max_ite
        d(n) = c(n);
        del(n-1) = d(n);
        d(n-1) = c(n-1) + s*d(n);
        del(n-2) = d(n-1) + s*del(n-1);

        for j= n-2:-1:1
            d(j) = c(j) + s*d(j+1) + r*d(j+2);
            del(j) = d(j+1)+ s*del(j+1) + r*del(j+2);
        end
        err_r = ((del(1)*d(2)-del(2)*d(1))/(del(2)*del(2)-del(1)*del(3)));
        err_s= ((del(3)*d(1)-del(2)*d(2))/(del(2)*del(2)-del(1)*del(3)));
        r = r + err_r;
        s = s + err_s;

        err1(i) = abs(err_r*100/r);
        err2(i) = abs(err_s*100/s);
        error = max(err1,err2);

        if error <= max_re
            disp('max error condition reached');
            break;
        end
    end
    if(i>=n)
        disp('max iterations reached');
    end
    disp('The Roots are : ');
    root1 = 0.5*(s + sqrt(s*s + 4*r));
    root2 = 0.5*(s - sqrt(s*s + 4*r));
    disp('Root 1 is  : ');
    disp(root1)
    disp('Root 2 is : ');
    disp(root2)
end