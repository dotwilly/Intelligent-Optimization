function result=JDS(x)  % J.D. Schaffer test function 
x1=x(1);
x2=x(2);
result=4.5-(sin(sqrt(x1.^2+x2.^2))^2-0.5)/(1+0.001*(x1.^2+x2.^2))^2; 
end