A=input("Enter coeff matrix")
b=input("Enter forcing matrix")
X=input("Enter initial guesses")
[m,n]= size(A);
er=-10000;
while abs(er)>0.1
er=-10000;
    for i=1:m
        prev=X(i);
        X(i)=b(i);
        for j=1:n
            if(i!=j)
                X(i)=X(i)-A(i,j)*X(j);
            end    
        end
        X(i)=X(i)/A(i,i);
        ea=abs((X(i)-prev)*100/X(i));
        er=max(ea,er);
    end
end
fprintf("\nThe roots are:");
disp(X);