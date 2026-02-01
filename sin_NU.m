function [x,t]=sin_NU(fs,f0,T)
t=0:1/fs:T;
x=sin(2*pi*f0*t);
end

