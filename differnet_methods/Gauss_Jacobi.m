#{
[10 2 -1 ; -3 -6 2 ; 1	1 -5]
[27 -61.5 -21.5]
[3 10 10]

#}

A=input("Enter coeff matrix")
b=input("Enter forcing matrix")
X=input("Enter initial guesses")
[m,n]= size(A);

er=-10000;
while abs(er)>0.1
er=-10000;
Xnew=zeros(m,1);
    for i=1:m
        Xnew(i)=b(i);
        for j=1:n
            if(i!=j)
                Xnew(i)=Xnew(i)-A(i,j)*X(j);   
            end    
        end
        Xnew(i)=Xnew(i)/A(i,i);
        ea=abs((Xnew(i)-X(i))*100/Xnew(i));
        er=max(ea,er);
        
    end
    X=Xnew;
end

   
fprintf("\nThe roots are:");
disp(Xnew);