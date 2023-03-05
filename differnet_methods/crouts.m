A= input("Insert Matrix");
disp(A);

[m n]=size(A);
##### Start decomposition of the matrix by LU method####
    L=zeros(m,n);
    U=zeros(m,n);
    
    ###after initialise diagonal entries of U to 1 ###
    for i=1:m
        U(i,i)=1;
    end    
    for j = 1:m
        for i = j:n
            sum = 0;
            for k = 1:j-1
                sum = sum + L(i,k)*U(k,j);
            end
            L(i,j) = A(i,j)-sum;
            sum = 0;
            for k = 1:j-1
                sum = sum + L(j,k)*U(k,i);
            end
            for k = j+1:m
                U(j,k) = (A(j,k)-sum)/L(j,j);
            end
            
        end  
    end 
L
U