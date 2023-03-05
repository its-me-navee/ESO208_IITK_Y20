name=input('enter the input file name\n');
filedata=textread(name,'%f');  
n=filedata(1);

A=reshape(filedata(2:end),n,n);

a=A';

b=zeros(repmat(n,1));
for i=1:n
    b(i,i)=1.0;
end
for k=1:n
        t=a(k,k);
        for j=k:n
            a(k,j)=a(k,j)/t;
        end
        for j=1:n
            b(k,j)=b(k,j)/t;
        end
   
    for i=1:n
        if i==k
            continue
        end
        
        t=-a(i,k);
        for j=k:n
            a(i,j)=a(i,j)+(a(k,j)*t);
        end
        for j=1:n
            b(i,j)=b(i,j)+(b(k,j)*t);
        end
    end
end
disp(b);
fileID = fopen ('inverse_output.txt', 'w');
  fprintf(fileID , 'Inverse method\n');
  fprintf(fileID, 'The solution is \n');
  fprintf(fileID,' %f %f %f %f\n', b);
  
  fclose(fileID);