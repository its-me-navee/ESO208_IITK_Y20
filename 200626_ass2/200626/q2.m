% Clearing Screen
% Navneet Singh
% 200626
% Q1
clc
% [8.0,-1.0,-1.0;-1.0,4.0,-2.0;-1.0,-2.0,10.0]

fID = fopen('input_q2.txt','rt');
        sizen = 1;
        n = fscanf(fID, '%f', sizen);
        sizeA1 = [n,n];
        A = fscanf(fID, '%f', sizeA1);
%selection of method
fprintf('Choose one of Four method given below -\n1.Direct power method\n2.Inverse power method\n3.Shifted-power method\n4.QR method');
m = input('\nIf you want to choose ith method then Enter "i" : ');
% choosing 1 of 4 method
if m==1
    m1(A,n,fID);
elseif m==2
    m2(A,n,fID);
elseif m==3
    m3(A,n,fID);
elseif m==4
    m4(A,fID);
end

% functions for each method
function m1(A,n,fID)
% inputs
i = fscanf(fID, '%f');
e = fscanf(fID, '%f');
 X = ones(size(A,2),1);
    Y = A*X;
    S = max(Y);
    X = Y/S;
    prev = S;
    for k=1:i-1
        Y = A*X;
        S = max(Y);
        err = abs ((prev-S)*100/S);
        prev = S;
        if err<e
            break;
        end
        X = Y/S;
    end
    evalue = S;
    evector = Y/norm(Y);
    it = k+1;
    filename = "output_q2.txt";
    outf = fopen(filename, "w");
    fprintf(outf,'Power Method\n');
    fprintf(outf,"Eigenvalue\n");
    fprintf(outf,"%f \n",evalue);
    fprintf(outf,"Eigenvector\n");
        for i = 1:n
            fprintf(outf,"%f\n", evector(i));
        end
    fprintf(outf,"Iterations\n");
    fprintf(outf,"%d",it);
end
function m2(A,n,fID)
% inputs
i = fscanf(fID, '%d');
e = fscanf(fID, '%f');
 A = inv(A);
 X = ones(size(A,2),1);
    Y = A*X;
    S = max(Y);
    X = Y/S;
    prev = S;
    for k=1:i-1
        Y = A*X;
        S = max(Y);
        err = abs ((prev-S)*100/S);
        prev = S;
        if err<e
            break;
        end
        X = Y/S;
    end
    evalue = 1/S;
    evector = Y/norm(Y);
    it = k+1;
    filename = "output_q2.txt";
    outf = fopen(filename, "w");
    fprintf(outf,'Inverse power Method\n');
    fprintf(outf,"Eigenvalue\n");
    fprintf(outf,"%f \n",evalue);
    fprintf(outf,"Eigenvector\n");
        for i = 1:n
            fprintf(outf,"%f\n", evector(i));
        end
    fprintf(outf,"Iterations\n");
    fprintf(outf,"%d",it);
end
function m3(A,n,fID)
% inputs
i = fscanf(fID, '%d');
e = fscanf(fID, '%f');
s = input('Enter Shifting scalar (s): ');
 %Shifting 
 A = A - s.*eye(n);
 %Inverse power method
 A = inv(A);
 
 X = ones(size(A,2),1);
    Y = A*X;
    S = max(Y);
    X = Y/S;
    prev = S;
    for k=1:i-1
        Y = A*X;
        S = max(Y);
        err = abs ((prev-S)*100/S);
        prev = S;
        if err<e
            break;
        end
        X = Y/S;
    end
    evalue = 1/S + s;  % S for max(Y) and s for shifting scalar
    evector = Y/norm(Y);
    it = k+1;
    filename = "output_q2.txt";
    outf = fopen(filename, "w");
    fprintf(outf,'Shifted-power Method\n');
    fprintf(outf,"Eigenvalue\n");
    fprintf(outf,"%f \n",evalue);
    fprintf(outf,"Eigenvector\n");
        for i = 1:n
            fprintf(outf,"%f\n", evector(i));
        end
    fprintf(outf,"Iterations\n");
    fprintf(outf,"%d",it);
end
function m4(A,fID)
% inputs
itr = 100;
tol= 0.001;
%itr = fscanf(fID,'%f');
%tol = fscanf(fID, '%f');
[n,~] = size(A);
Q = zeros(n,n);
    e = zeros(n,1);
    R = zeros(n,n);
    A_prev=zeros(n,1);
    err= 100;
    t=0;
    while (err>tol && t<itr)
        for i=1:n
            Q(i,1) = A(i,1)/norm(A(:,1));
        end
        for j=2:n
%             sum = zeros(n,1);
            sum=0;
            for i=1:j-1
                sum =sum + (Q(:,i)'*A(:,j))*Q(:,i);
            end
            e(:,1) = A(:,j)- sum;
            for i=1:n
                Q(i,j) = e(i,1)/norm(e);
            end
        end
        for i=1:n
            for j=1:n
                R(i,j) = Q(:,i)'*A(:,j);
            end
        end
        A = R*Q;
        er = zeros(n,1);
        for i=1:n
            er(i)= abs((A(i,i)-A_prev(i))/A(i,i))*100;
            A_prev(i)=A(i,i);
        end
        err=max(er);
        t=t+1;
    end
B = zeros(n,1);
for i=1:1:n
    B(i,1)= A(i,i);
end
 filename = "output_q2.txt";
    outf = fopen(filename, "w");
    fprintf(outf,'QR Method\n');
    fprintf(outf,"Eigenvalue\n");
        for i = 1:n
            fprintf(outf,"%f\n", B(i));
        end
    fprintf(outf,"Iterations\n");
    fprintf(outf,"%d",t);
end