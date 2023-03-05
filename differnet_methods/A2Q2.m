#{
%%%%%%%%%%%%%%%%%%%%%%%% GENERAL INPUT SYNTAX %%%%%%%%%%%%%%%%%%%%%%%%
    Size of matrix n for a matrix(n x n)
    Coefficient matrix A [ a b ; c d] for any dimension n accordingly
    Error limit in percentage
    Method( L: largest/smallest and A: All eigenvalues !!ONLY CAPITAL!!)
    
%%%%%%%%%%%%%%%%%%%%%%%%SAMPLE INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%% For QR decomposition %%%%%%%%

2
[4 3;6 4]
0.1
A

%%%%%%%% For Power/Inv Power %%%%%%%%%
2
[4 3;6 4]
0.1
L


%%%%%%%%%%%%%%%%%%%%%%%% SAMPLE OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
INPUTS AS ENTERED BY USER
EIGENVALUES AND CORRESPONDING EIGENVECTORS FOR POWER METHOD
ALL EIGENVALUES FOR QR DECOMPOSITION

%%%%%%%%%%%%%%%%%%%%%%%%  NOTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Even though max iteration have not been taken as input as per the question, in case the problem is super slow to converge, please set max iterations to a finite number for QR(default to 999) on line 67

For power method, max iteration is not set, as the method is somewhat faster but the condition can be incorporated as ops<max_iter in the while loops on line 194 and line 138.

Initial Arbitrary vector for power and inverse power was not taken as input as per the question. This vector is set to a column vector with all entries one. For different problems, it may be better to use other initial vectors. This can be edited and set as g on line 126 by the user
#}

%%%%%%%%%%%%%%%%%% CODE STARTS HERE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n= input("Enter size n of the matrix: ")
A = input("\n Enter the coefficient matrix : ")
err= input("\n Enter approximate relative error tolerance :")
Method= input("\nIf you want only the largest/ smallest eigenvalue, press(L) or for all eigenvalues press(A): ",'s')

err=err/100; %error was in percentage in input

%%%%%%%%%%%%%%%%%%% QR DECOMPOSITION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(Method=='A') 
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
    while(ops<999) %for cases we are unable to converge, say ops<999
        
        % Initialization of z,Q,R
        z = zeros(n,1);
        Q = zeros(m,n);
        R = zeros(n,n);
    
        % Initializing the Q1 vector
        for i = 1:m
            Q(i,1) = A(i,1) / norm(A(:,1));
        end
        % Iterative Loop for Qi
        for i = 2:n
            
            sum= zeros(n,1);
            for k = 1:i-1
                sum = sum + (A(:,i).'*Q(:,k))*Q(:,k);
            end
            
            z = A(:,i) - sum;
            
            for j = 1:m
                Q(j,i) = z(j)/norm(z);
            end
        end
       
%%%%%%%%Calculation for R %%%%%%%%
        for i=1:n
            for j=1:n
                R(i,j)= Q(:,i).'* A(:,j);
            end
        end
       
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

%%%%%%%%%%%%%%%%%%%%%% POWER METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else 
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
            fprintf("\nNorm calculated as 0, hence process is terminated and Largest Eigenvalue is 0");
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
     
%%%%%%%%%%%%%%%%%%%   INVERSE POWER METHOD    %%%%%%%%%%%%%%%%%%%%%%%%%%%

% singular matrix, terminate
    if(rank(A)<n)
    fprintf("\nThe smallest eigenvalue is: 0 and the corresponding eigenvector is:\n");
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
 
end   