clc
N=input('Enter the order of polynomial (an integer <n) \n');
n=N+1;
M = readmatrix("ass3_q2.txt");
fID = fopen('ass3_q2.txt','rt');
n_pts = fscanf(fID,'%d',1);
sizeA1 = [n_pts,2];
x = M(:,1);
y = M(:,2);
A=zeros(n);
b=zeros(n,1);
for i = 1:n
    b(i)=y'*(x.^(i-1));
    for j = i:n
        A(i,j)=transpose(x.^(j-1))*x.^(i-1);
        A(j,i)=A(i,j);
    end
end

i=0;
j=0;
k=0;
m=0;
A;
b;
X=zeros(1,n);
for k = 1:n-1
    for i = k+1:n
        m=A(i,k)/A(k,k);
        A(i,k)=0;
        b(i)=b(i)-m*b(k);
        for j = k+1:n
            A(i,j)=A(i,j)-m*A(k,j);
        end
        A;
    end
end
A;
b;
X(n)=b(n)/A(n,n);
for i = n-1:-1:1
    m=0;
    for j = i+1:n
        m=m+A(i,j)*X(j);
    end
    X(i)=(b(i)-m)/A(i,i);
end
num_points = A(1,1);
X=fliplr(X);
y_=polyval(X,x);
mu= sum(y)/num_points;
sigma=sum((y-mu).^2);
eps=sum((y-y_).^2);
r_square=1-eps/sigma;
x1 = linspace(min(x),max(x));
y1 = polyval(X,x1);
p = poly2sym(X);
coff = coeffs(p);
plot(x,y,'ro')
hold on
k=plot(x1,y1,'g');
xlabel('x');
ylabel('y');
hold off
matrix = coeffs(p);
outf = fopen('Least_Square.txt','w');
fprintf(outf,'coefficients of %d degree polynomials\n',n-1);
for j = 1:length(matrix)
    fprintf(outf,"%.3f\t",matrix(1,j));
end
fprintf(outf,'\ncoefficient of determination/r_square for %d degree polynomials\n',n-1);
fprintf(outf,'%.3f\n', r_square);
fclose(outf);