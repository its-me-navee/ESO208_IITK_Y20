n= input("Enter size n of the matrix: ")
A = input("\n Enter the coefficient matrix, A : ")
err= input("\n Enter approximate relative error tolerance:")
err=err/100; %error was in percentage in input


% singular matrix, terminate
    if(rank(A)<n)
    fprintf("\nThe smallest eigenvalue is: 0 and the corresponding eigenvector is:\n");
    y=[1;0]
    return 
    end
 
%not a singular matrix, move ahead    
    M=inv(A);
    m=n; %m and n are dimension of matrix which are same in this case
        z=M*g;
        sign=1;
        %evaluate sign for zmax for 1st iter
        maxval= norm(z,Inf);
        for i=1:n
            if(abs(z(i,1))==maxval)
                if(z(i,1)<0) sign=-1;
                else sign=1; end;
            end
        end
        y=z/(sign*norm(z,inf));
        lambda=sign*max(abs(z(:,1)));
        
        %continue iterations further
        while(1)
            plambda=lambda;%p lambda refers to previous lambda
            z=M*y;
            %evaluate sign for zmax
            maxval= max(abs(z(:,1)));
            for i=1:n
                if(abs(z(i,1))==maxval)
                    if(z(i,1)<0) sign=-1; 
                    else sign=1; end;
                end
            end
            y = z/(sign*norm(z,Inf));
            lambda=sign*norm(z,Inf);
            if (abs((lambda-plambda)/lambda)<err)
        %% fprintf("Smallest Eigenvalue for inverse is: %d",lambda);
                break;
            end;
        end;
      
      flambda=1/lambda;
      fprintf("\nSmallest Eigenvalue is: ");
      disp(flambda);
      fprintf("corresponding to eigen vector:\n");
      y
 