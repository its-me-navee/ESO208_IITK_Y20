clc
format long
prompt = ('What do you want to do\n A-Fit a Lagrange Interpolation Polynomial\n B-Fit Cubic splines\n ');
str = input(prompt,'s');
if strcmp(str, 'A')
    M = readmatrix('input_q1.txt');
    X = M(:,1);
    Y = M(:,2);
    if size(X,1) > 1;  X = X'; end % checking for parameters
    if size(Y,1) > 1;  Y = Y'; end
    if size(X,1) > 1 || size(Y,1) > 1 || size(X,2) ~= size(Y,2)
        error('both inputs must be equal-length vectors') % displaying error
    end % end of scope of if
    N = length(X);
    pvals = zeros(N,N);
    % for evaluating  the polynomial weights for each order
    for i = 1:N
        % the polynomial with roots may be values of X other than this one
        pp = poly(X( (1:N) ~= i));
        pvals(i,:) = pp ./ polyval(pp, X(i));
    end
    %P = Y*pvals;
    l = Y*pvals;
    fID = fopen('value_eval_pts.txt');
    f = fscanf(fID,'%d',1);
    Z = zeros(f);
    for i = 1:f
        Z(i) = fscanf(fID,'%f ',1);
    end
    fclose(fID);

    sum = zeros(f);
    for j = 1 : f
        sum(j) = 0;
        for i=1:N
            sum(j) = sum(j)+ l(i)*(Z(j)^(N-i));
        end
    end
    fileid = fopen('output_lagrange.txt','w');
    fprintf(fileid,'%s','Interpolated values of y at given x* ');
    fprintf(fileid,'\n');
    fprintf(fileid,'%s','Lagrange Polynomials : ');
    fprintf(fileid,'\n');
    for i=1:f
        fprintf(fileid,'%.4f %.4f\n',Z(i),sum(i));
    end
    figure;
    z = poly2sym(l);
    plot(X,Y,'ro')
    hold on
    k = fplot(z,[min(X),max(Y)],'g');
    xlabel('x');
    ylabel('y');
    legend(k,'Lagrange Polynomials');
    hold off;
end

if strcmp(str,'B')
    M = readmatrix('input_q1.txt');
    fID = fopen('value_eval_pts.txt');
    f = fscanf(fID,'%d',1);
    sizeA1 = [1,Inf];
    X = fscanf(fID, '%f', sizeA1);
    X = X';
    fclose(fID);
    x = M(:,1);
    y = M(:,2);

    n=length(x);
    h=zeros(n-1,1);
    for i=1:n-1
        h(i,1)=x(i+1,1)-x(i,1);
    end
    a=zeros(n,n);
    %boundary condition
    a(1,1)=1;
    a(n,n)=1;
    for i=2:n-1
        a(i,i-1)=h(i-1,1);
        a(i,i)=2*(h(i-1,1)+h(i,1));
        a(i,i+1)=h(i,1);
    end
    b=zeros(n,1);
    g=zeros(n,1);
    for i=2:n
        g(i,1) = (y(i,1)-y(i-1,1))/h(i-1,1);
    end
    for i=2:n-1
        b(i,1) = 6*(g(i+1,1)-g(i,1));
    end
    sigma=inv(a)*b;
    A=zeros(n-1,1);
    B=zeros(n-1,1);
    C=zeros(n-1,1);
    D=zeros(n-1,1);
    for i=1:n-1
        A(i,1)=sigma(i+1,1)/(6*h(i,1));
        B(i,1)=sigma(i,1)/(6*h(i,1));
        C(i,1)=(y(i+1,1)/h(i,1))-(sigma(i+1,1)*h(i,1)/6);
        D(i,1)=(y(i,1)/h(i,1))-(sigma(i,1)*h(i,1)/6);
    end

    i = ones(size(X));
    for j=1:n
        i(x(j,1) <= X) = j;
    end
    Y=A(i,1).*((X-x(i,1)).^3)-B(i,1).*((X-x(i+1,1)).^3)+C(i,1).*(X-x(i,1))-D(i,1).*(X-x(i+1,1));
    fileid=fopen('output_cubic_spline.txt','w');
    fprintf(fileid,'%s','Interpolated values of y at given x* ');
    fprintf(fileid,'\n');
    fprintf(fileid,'%s','Cubic Spline: ');
    fprintf(fileid,'\n');
    for i=1:f
        fprintf(fileid,'%.4f %.4f\n',X(i),Y(i,1));
    end

    plot(x,y,'ro');
    hold on;
    for i=1:n-1
        x1=x(i,1):0.001:x(i+1,1);
        y1=A(i,1).*((x1-x(i,1)).^3)-B(i,1).*((x1-x(i+1,1)).^3)+C(i,1).*(x1-x(i,1))-D(i,1).*(x1-x(i+1,1));
        k=plot(x1,y1,'g');
    end
    xlabel('x');
    ylabel('y');
    legend(k,'Cubic Spline');
end
