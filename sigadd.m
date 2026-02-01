function [y,n]=sigadd(x1,n1,x2,n2)

subplot(2,2,1);
stem(n1,x1);
title('First Signal')
xlabel('n1');
ylabel('x1(n1)');

subplot(2,2,2);
stem(n2,x2);
title('Second Signal')
xlabel('n2');
ylabel('x2(n2)');

n=min(min(n1),min(n2)):max(max(n1),max(n2));
y1=zeros(1,length(n));
y2=zeros(1,length(n));
y1(  find( (n>=min(n1))  & (n<=max(n1)) )   )=x1;
y2 (  find( (n>=min(n2))  & (n<=max(n2)) )   )=x2;
y=y1+y2;

subplot(2,2,[3 4]);
stem(n,y);
title('Result Signal of the addition')
xlabel('n');
ylabel('y(n)');

end
% For test:
%x1=[3 4 6 9 0];
%n1=-1:3;
%x2=[1 0 5 8 4 2 7];
%n2=-2:4;
%[y,n]=sigadd(x1,n1,x2,n2);