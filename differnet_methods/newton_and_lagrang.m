X = input("Input values of x- ");
disp(X)
Y = input("Input values of y- ");
disp(Y)
Order = input("Input order of polynomial- ");
disp(Order)
x = input("Value to be found at- ");
disp(x)
choice = input("Enter choice- ");
disp(choice)
n = length(X);
sum=0;
sumfinal=0;
diffe = 0;
switch choice
    case 1
        if Order< n && x>X(1) && x<X(n)
             for i = 1:n
               diffe(i) = abs(x-X(i));
             end
             A = [diffe;X;Y];
             B = sortrows(A',1);
             for i=1:(Order+1)
                 p=1;
                 for j=1:(Order+1)
                     if j~=i
                         c = poly(B(j,2))/(B(i,2)-B(j,2));
                         p = conv(p,c);
                     end
                 end
                 term = p*B(i,3);
                 sum= sum + term;
             end
             printf("The coefficients are");
             disp(sum)
             for i=1:(Order+1)
                 p=1;
                 for j=1:(Order+1)
                     if j~=i
                         c = (x-B(j,2))/(B(i,2)-B(j,2));
                         p = p*c;
                     end
                 end
                 termfinal = p*B(i,3);
                 sumfinal= sumfinal + termfinal;
             end
             printf("Interpolated value is");
             disp(sumfinal)
             for i = 1:Order+1
                Xvalues(i) = B(i,2);
                Yvalues(i) = B(i,3);
             end
             Xvalues(i+1) = x;
             Yvalues(i+1) = sumfinal;
             p = figure(1, "visible", "off");
             plot(Xvalues, polyval(sum,Xvalues),"*",Xvalues,Yvalues);
             title('Plot of x v/s y');
             xlabel('xvalues');
             ylabel('fitted values');
             
             prutorsaveplot(p, "myplot2.pdf");
        else
            printf("Warning");
        end
        printf("Insufficient data for error analysis");
    case 2    
        S = zeros(n,n);
        if Order< n && x>X(1) && x<X(n)
             for i = 1:n
               diffe(i) = abs(x-X(i));
             end
             A = [diffe;X;Y];
             B = sortrows(A',1);
             S(:,1) = B(:,3);
             for i=2:(Order+1)
                 for j=i:Order+1
                    S(j,i) = (S(j,i-1)-S(j-1,i-1))/(B(j,2)-B(j-i+1,2));
                 end
             end
             C = S(Order+1,Order+1);
             for k=(Order):-1:1
                C = conv(C,poly(B(k,2)));
                m = length(C);
                C(m) = C(m) + S(k,k);
             end
             printf("The coefficients are");
             disp(C)
             D = S(Order+1,Order+1);
             for k=(Order):-1:1
                D = D*(x-B(k,2));
                D = D + S(k,k);
             end
             printf("The interpolated value is");
             disp(D)
             if n>Order+1
                for i=2:(Order+2)
                    for j=i:Order+2
                        S(j,i) = (S(j,i-1)-S(j-1,i-1))/(B(j,2)-B(j-i+1,2));
                    end
                end
                 E = S(Order+2,Order+2);
                 for k=(Order+1):-1:1
                    E = E*(x-B(k,2));
                 end
                 printf("Approximat Error is");
                 disp(E)
             else
                printf("Insufficient data for error analysis");
             end
             for i = 1:Order+1
                Xvalues(i) = B(i,2);
                Yvalues(i) = B(i,3);
             end
             Xvalues(i+1) = x;
             Yvalues(i+1) = D;
             p = figure(1, "visible", "off");
             plot(Xvalues, polyval(C,Xvalues),"*",Xvalues,Yvalues);
             title('Plot of x v/s y');
             xlabel('xvalues');
             ylabel('fitted values');
             
             prutorsaveplot(p, "myplot2.pdf");
        else
            printf("Warning");
        end
        
end
