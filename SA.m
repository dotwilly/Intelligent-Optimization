% Simulated Annealing
t0=1000000;% Initial temperature
x1=(rand()-0.5);
x2=(rand()-0.5);% Initial value

value=JDS([x1,x2]);
value0 = value;% Calculate initial function value
x10=0;
x20=0;% Record the optimal solution
k=0;% Record the number of runs
s=1;% Step size

while t0>0.000001
    for i=1:10000
        x11=x1+(rand()-0.5)*s;
        x21=x2+(rand()-0.5)*s;
        value1=JDS([x11,x21]);
        if (value1 > value) || ( exp(-(value1-value)/t0)>rand())
            x1=x11;
            x2=x21;
            value=value1;
            if value1 < value0
                x10=x11;
                x20=x21;
                value0=value1;
            end
        end
    end
    t0=t0*0.95;% Decrease temperature
    s=s*0.95;% Decrease step size
    k=k+1;
    disp(t0);
end
disp(k);
disp([x1,x2,value]);
disp([x10,x20,value0]);

fprintf('Simulated Annealing Results:\n');
fprintf('x1,x2: %f,%f \nValue: %f\n',x10,x20,value0);

