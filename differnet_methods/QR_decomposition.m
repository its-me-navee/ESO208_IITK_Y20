n= input("Enter size n of the matrix: ")
A = input("\n Enter the coefficient matrix, A : ")
err= input("\n Enter approximate relative error tolerance:")

err=err/100; %error was in percentage in input

if (rank(A)<n) %%%%%%%%singular matrix wont work for QR%%%%%%%%
        fprintf("\n\nMatrix is singular , try again with another matrix!");
        return;
    end

%%%%%%%% Matrix is not singular, hence we evaluate further%%%%%%%%
%here [m n] is matrix dimension but we have a square matrix hence m=n
    m=n;
    ops=0; % initially no of operations performed is 0
    diagA=zeros(n,1); %This is diagonal of A, which has eigenvalues
    errA=ones(n,1); %This is error vector for each diagonal elt of A
    for i=1:n
        diagA(i)=A(i,i);% put diagonal elements in diagonal vector
    end
 
    
%%%%%%%% START LOOP FOR QR DECOMPOSITION %%%%%%%%   
    while(ops<9999) %for cases we are unable to converge, say ops<9999
        
        % Initialization of z,Q,R
        z = zeros(n,1);
        Q = zeros(m,n);
        R = zeros(n,n);
       
        % Initializing the Q vector
        for i = 1:m
            Q(i,1) = A(i,1) / norm(A(:,1));
        end
        % Iterative Loop for Q
        for i = 2:n
            
            sum = zeros(m,1);
            
            for k = 1:i-1
                  sum = sum + (A(:,i)'*Q(:,k))*Q(:,k);
            end
            
            z = A(:,i) - sum;
            
            for j = 1:m
                Q(j,i) = z(j)/norm(z);
            end
        end
        
%%%%%%%%Calculation for R %%%%%%%%
        Qinv= inv(Q);
        R=Qinv*A;
       
%%%%%%%% For 2nd operation onwards(op=1), find error %%%%%%%%
        if(ops>0)
            for i=1:n
                errA(i)= abs((A(i,i)-diagA(i))/A(i,i));
            end
        end 
        
        for i=1:n
               diagA(i)=A(i,i); %% update diagA which has eigenvalues
               if(norm(errA)<=err) break; end; 
               %Error(norm of error vector) is less than limit, break!
        end
        
        ops=ops+1; %%increase operation count(aka iter count)
        A= R*Q ; %%This is A for next iteration
        
        
    end    
            
    fprintf("\n All the eigen values are:\n");
    disp(diagA);    %The diagonal had eigenvalues  
