n= input("Enter size n of the matrix: ")
A = input("\n Enter the coefficient matrix, A : ")
err= input("\n Enter approximate relative error tolerance:")
err=err/100; %error was in percentage in input


%% here [m n] is matrix dimension but we have a square matrix hence m=n
    m=n; 
    g=ones(n,1); %initial arbitrary vector
    z=A*g; 
    sign=1;
    maxval= max(abs(z(:,1)));
    for i=1:n
            if(abs(z(i,1))==maxval)
                if(z(i,1)<0) sign=-1; 
                else sign=1; end;
            end
    end
    y=z/(sign*norm(z,inf));
    lambda=max(abs(z(:,1))); %lambda is the eigenvalue
    while(1)
        plambda=lambda; %%plambda stands for previous value of lambda
        z=A*y;
        %Evaluate sign for zmax
        maxval= max(abs(z(:,1)));
        for i=1:n
            if(abs(z(i,1))==maxval)
                if(z(i,1)<0) sign=-1; 
                else sign=1; end;
            end
        end
        lambda=sign*max(abs(z(:,1)));

%Now if we have cases like[0 2;0 0], the norm would reduce to 0, which will prevent us from evaluating y, therefore for such erroneous matrices, break the loop and output eigenvalue as 0

        if(lambda==0)
            fprintf("\nLargest Eigenvalue is 0 and the corresponding eigenvector is: \n");
            y=[0;1]
            break;
        end
        
        y = z/(sign*norm(z,Inf)); %evaluate y using norm of z
        if (abs((lambda-plambda)/lambda)<err) 
        %error is less than limit, eigenvalue found, hence break;
            fprintf("\nLargest Eigenvalue is:");
            disp(lambda);
            fprintf("corresponding to eigen vector:\n");
            y
            break;
        end;
    end;
     