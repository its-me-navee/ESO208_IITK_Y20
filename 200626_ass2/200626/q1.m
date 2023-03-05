                                            % Navneet Singh
                                            % 200626
                                            % Q1
clc
        fID = fopen('input_q1.txt','rt');
        sizen = 1;
        n = fscanf(fID, '%f', sizen);
        sizeA1 = [n+1,Inf];
        aug = fscanf(fID, '%f', sizeA1);
        aug = aug';

A = aug(:,1:n);
b = aug(:,n+1) ;

%selection of method
fprintf('\nChoose one of Five method given below -\n1.GE (without pivoting)\n2.GE (with pivoting)\n3.LU decomposition by Doolittle method (without pivoting)\n4.LU decomposition by using Crout method (without pivoting)\n5.Cholesky decomposition (for symmetric positive definite matrix) ');
m = input('\nEnter algorithm number to use : ');
fprintf('\n');

% choosing 1 of 5 method
if m==1
    m1(aug,n);
elseif m==2
    m2(aug,n);
elseif m==3
    m3(A,b,n);
elseif m==4
    m4(A,b,n);
elseif m==5
    m5(A,b,n);
end

% functions for each method
function m1(aug,n)
l = zeros(n); 
    for k=1:n
        if (aug(k,k)==0)
            disp('ERROR in input Corresponding this method!')
            return;
        end
        
        for i=k+1:n
            l(i,k)=aug(i,k)/aug(k,k);
            aug(i,:)=aug(i,:)- l(i,k)*aug(k,:); 
        end
    end
    
    A = aug(:,1:n);
    b = aug(:,n+1);
    x=zeros(n,1);
    x(n)= b(n)/A(n,n);
    
    for i=n-1:-1:1
        sum=0;
        for j=i+1:n
            sum = sum + A(i,j)*x(j);
        end
        x(i)=(b(i)-sum)/A(i,i);
    end
    filename = "output_q1.txt";
    outf = fopen(filename, "w");
    fprintf(outf,'Solution by Gauss elimination (GE without pivoting) Method\n');
    fprintf(outf,"X\n");
        for i = 1:n
            fprintf(outf,"%f\n", x(i));
        end
end
function m2(aug,n)
l = zeros(n); 
    for k=1:n
         %Doing partial pivoting
        [M,P]=max(abs(aug(k:n,k))); %M=maximum P=position
        p = eye(n);
        p( [k, k+P-1], : ) = p( [k+P-1, k], : );
        aug = p*aug;
        
        if (aug(k,k)==0)
            disp('ERROR in input Corresponding this method!')
            return;
        end
        
        for i=k+1:n
            l(i,k)=aug(i,k)/aug(k,k);
            aug(i,:)=aug(i,:)- l(i,k)*aug(k,:); 
        end
    end
    
    A = aug(:,1:n);
    b = aug(:,n+1);
    %back substitution%
    x=zeros(n,1);
    x(n)= b(n)/A(n,n);
    
    for i=n-1:-1:1
        sum=0;
        for j=i+1:n
            sum = sum + A(i,j)*x(j);
        end
        x(i)=(b(i)-sum)/A(i,i);
    end
    filename = "output_q1.txt";
    outf = fopen(filename, "w");
    fprintf(outf,'Solution by Gauss elimination (GE with pivoting) Method\n');
    fprintf(outf,"X\n");
        for i = 1:n
            fprintf(outf,"%f\n", x(i));
        end
end

function m3(A,b,n)
l = zeros(n); 
    for k=1:n
        if (A(k,k)==0)
            disp('ERROR in input Corresponding this method!')
            return;
        end
        
        for i=k+1:n
            l(i,k)=A(i,k)/A(k,k);
            A(i,:)=A(i,:)- l(i,k)*A(k,:); 
        end
        l(k,k)=1;
    end
    L=l;
    U=A;
    %forword substitution%
    y=zeros(n,1);
    y(1)= b(1)/L(1,1);
    
    for i=2:n
        sum=0;
        for j=1:i-1
            sum = sum + L(i,j)*y(j);
        end
        y(i)=(b(i)-sum)/L(i,i);
    end
    
    %back substitution%
    x=zeros(n,1);
    x(n)= y(n)/U(n,n);
    
    for i=n-1:-1:1
        sum=0;
        for j=i+1:n
            sum = sum + U(i,j)*x(j);
        end
        x(i)=(y(i)-sum)/U(i,i);
    end
     filename = "output_q1.txt";
    outf = fopen(filename, "w");
    fprintf(outf,'Solution using LU decomposition by Doolittle method (without pivoting) Method\n');
    fprintf(outf,"X\n");
        for i = 1:n
            fprintf(outf,"%f\n", x(i));
        end
    fprintf(outf,"L\n");
    for i = 1:n
        for j = 1:n
            fprintf(outf,"%f  ",L(i,j));
        end
        fprintf(outf,"\n");
    end
    fprintf(outf,"U\n");
    for i = 1:n
        for j = 1:n
            fprintf(outf,"%f  ",U(i,j));
        end
        fprintf(outf,"\n");
    end
end

function m4(A,b,n)
L=zeros(n); 
U=zeros(n); 
for k=1:n
    U(k,k)=1;
end
L(:,1)=A(:,1);
U(1,:)=A(1,:)/L(1,1);

for i=2:n
    for k=i:n
        L(k,i)=A(k,i) - L(k,1:i-1)*U(1:i-1,i);
    end
    for j=i+1:n
        U(i,j) = (A(i,j) - L(i,1:i-1)*U(1:i-1,j))/L(i,i);
    end
end
    %forword substitution%
    y=zeros(n,1);
    y(1)= b(1)/L(1,1);
    
    for i=2:n
        sum=0;
        for j=1:i-1
            sum = sum + L(i,j)*y(j);
        end
        y(i)=(b(i)-sum)/L(i,i);
    end
    
    %back substitution%
    x=zeros(n,1);
    x(n)= y(n)/U(n,n);
    
    for i=n-1:-1:1
        sum=0;
        for j=i+1:n
            sum = sum + U(i,j)*x(j);
        end
        x(i)=(y(i)-sum)/U(i,i);
    end
    filename = "output_q1.txt";
    outf = fopen(filename, "w");
    fprintf(outf,'Solution using Crout method (without pivoting) Method\n');
    fprintf(outf,"X\n");
        for i = 1:n
            fprintf(outf,"%f\n", x(i));
        end
    fprintf(outf,"L\n");
    for i = 1:n
        for j = 1:n
            fprintf(outf,"%f  ",L(i,j));
        end
        fprintf(outf,"\n");
    end
    fprintf(outf,"U\n");
    for i = 1:n
        for j = 1:n
            fprintf(outf,"%f  ",U(i,j));
        end
        fprintf(outf,"\n");
    end
end
function m5(A,b,n)
l=zeros(n);

for k=1:n
    for i=1:k
        sum=0;
        for j=1:i-1
            sum=sum+l(i,j)*l(k,j);
        end
        l(k,i)= (A(k,i)-sum)/l(i,i);
    end
    sum=0;
    for j=1:k-1
        sum=sum + l(k,j).^2;
    end
    l(k,k)=sqrt(A(k,k)-sum);
end
    L=l;
    U=transpose(l);
    %forword substitution%
    y=zeros(n,1);
    y(1)= b(1)/L(1,1);
    
    for i=2:n
        sum=0;
        for j=1:i-1
            sum = sum + L(i,j)*y(j);
        end
        y(i)=(b(i)-sum)/L(i,i);
    end
    
    %back substitution%
    x=zeros(n,1);
    x(n)= y(n)/U(n,n);
    
    for i=n-1:-1:1
        sum=0;
        for j=i+1:n
            sum = sum + U(i,j)*x(j);
        end
        x(i)=(y(i)-sum)/U(i,i);
    end
    filename = "output_q1.txt";
    outf = fopen(filename, "w");
    fprintf(outf,'Solution by Cholesky (for symmetric positive definite matrix)\n');
    fprintf(outf,"X\n");
        for i = 1:n
            fprintf(outf,"%f\n", x(i));
        end
    fprintf(outf,"L\n");
    for i = 1:n
        for j = 1:n
            fprintf(outf,"%f  ",L(i,j));
        end
        fprintf(outf,"\n");
    end
end

