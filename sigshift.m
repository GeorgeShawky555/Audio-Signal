function [y,n]=sigshift(x,n,k)
subplot(1 ,2 ,1);
stem (n,x);
axis([-6 6 -2 5]);
n=n+k;
y=x;
subplot(1 ,2 ,2);
stem(n,y);
axis([-6 7 -2 5]);
end
