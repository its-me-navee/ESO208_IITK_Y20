
A= input("Insert Matrix");
disp(A);

[m n]=size(A);
##### Start decomposition of the matrix by LU method####
    L=zeros(m,n);
    U=zeros(m,n);
    
    for i = 1:n
        L(i,i) = 1;
    end

      for i = 1:n
        for j = i:n
            sum = 0;
            for k = 1:i-1
                sum = sum + L(i,k)*U(k,j);
            end
                U(i,j) = A(i,j)-sum;
             sum = 0;
             for k = 1:i-1
                sum = sum + L(j,k)*U(k,i);
             end
                L(j,i) = (A(j,i)-sum)/U(i,i);
         end  
    end


L
U