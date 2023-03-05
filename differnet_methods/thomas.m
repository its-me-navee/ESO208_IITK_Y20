name=input('enter the input file name\n');
filedata=textread(name,'%f'); 

n=filedata(1);

A=reshape(filedata(2:end),n,n);

a=A';
l=a(:,1);
d=a(:,2);
u=a(:,3);
b=a(:,4);
A=zeros(1,n);
B=zeros(1,n);
x=zeros(1,n);
A(1)=d(1);
B(1)=b(1);
for i=2:n
    A(i)=d(i)-((l(i)/A(i-1))*u(i-1));
end
for i=2:n
    B(i)=b(i)-((l(i)/A(i-1))*B(i-1));
end
x(n)=B(n)/A(n);
for i=n-1:-1:1
    x(i)=(B(i)-(u(i)*x(i+1)))/A(i);
end
disp(x);
fileID = fopen ('thomas_output.txt', 'w');
  fprintf(fileID , 'Thomas method\n');
  fprintf(fileID, 'The solution is \n');
  fprintf(fileID,' %f %f %f %f\n', x);
  
  fclose(fileID);